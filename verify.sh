#!/bin/bash
# =====================================================================
# Kodukaityou_APP (KOZUKAITYOU) 検証ハーネス（AIエージェント向け）
#
# 使い方:
#   ./verify.sh --check   ツール存在確認と実行予定ステップの表示のみ（数秒）
#   ./verify.sh           高速検証: 構成確認 + xcodebuild build（目安5分以内）
#   ./verify.sh --full    重い検証: pod install + build + test
#
# 契約:
#   - 出力は "[n/m] ステップ名" 形式。最後に VERIFY PASS / VERIFY FAIL(exit 1)
#   - ツール欠如時: --check は WARN、無印/--full は SKIP を正直に表示
#   - 無印はリポジトリの状態を変更しない。pod install（Pods/ を生成・更新する
#     状態変更操作）は --full のみで、実行前にその旨を表示する
#
# リポ構成（実確認済み）:
#   - CocoaPods 構成: Podfile（target 'KOZUKAITYOU', platform ios 17.0）
#   - KOZUKAITYOU.xcworkspace は KOZUKAITYOU.xcodeproj と Pods/Pods.xcodeproj を
#     参照するため、pod install 未実施だと xcodebuild は失敗する
#   - 共有scheme: KOZUKAITYOU（KOZUKAITYOU.xcodeproj/xcshareddata/xcschemes/）
#   - テストターゲット（KOZUKAITYOUTests / KOZUKAITYOUUITests）は Xcode 雛形の
#     空実装のみ（testExample 等）。--full の test は形式確認の意味しかない
#
# 互換性: bash 3.2 / BSD ユーティリティ（mapfile・grep -P は不使用）
# =====================================================================
set -euo pipefail
cd "$(cd "$(dirname "$0")" && pwd)"

MODE="fast"
case "${1:-}" in
  --check) MODE="check" ;;
  --full)  MODE="full" ;;
  "")      MODE="fast" ;;
  *)
    echo "不明な引数: ${1}（使用可能: --check / 無印 / --full）"
    exit 2
    ;;
esac

STEP=0
TOTAL=0
RUN_COUNT=0
SKIP_COUNT=0

step() { STEP=$((STEP + 1)); echo "[${STEP}/${TOTAL}] $1"; }
ok()   { RUN_COUNT=$((RUN_COUNT + 1)); echo "  OK: $1"; }
skip() { SKIP_COUNT=$((SKIP_COUNT + 1)); echo "  SKIP: $1"; }
info() { echo "  INFO: $1"; }
fail() {
  echo "  NG: $1"
  echo "VERIFY FAIL"
  exit 1
}
have() { command -v "$1" >/dev/null 2>&1; }

finish() {
  echo "結果: 実行 ${RUN_COUNT} 件 / SKIP ${SKIP_COUNT} 件"
  echo "VERIFY PASS"
  exit 0
}

WS="KOZUKAITYOU.xcworkspace"
SCHEME="KOZUKAITYOU"

XCODEBUILD_OK=0
if have xcodebuild && xcodebuild -version >/dev/null 2>&1; then
  XCODEBUILD_OK=1
fi

if [ "$MODE" = "check" ]; then
  TOTAL=2
  step "ツール存在確認"
  if [ "$XCODEBUILD_OK" -eq 1 ]; then
    echo "  ツール xcodebuild: 有（$(xcodebuild -version | head -n 1)）"
  else
    echo "  ツール xcodebuild: WARN 使用できない（Xcode が必要）"
  fi
  if have pod; then
    echo "  ツール pod: 有（CocoaPods $(pod --version 2>/dev/null)）"
  else
    echo "  ツール pod: WARN 見つからない（--full の pod install が実行不可。gem install cocoapods 等）"
  fi
  if have xcrun && xcrun simctl help >/dev/null 2>&1; then
    echo "  ツール simctl: 有（--full の test でシミュレータ検出に使用）"
  else
    echo "  ツール simctl: WARN 使用できない（--full の test が実行不可）"
  fi
  step "実行予定ステップ表示"
  echo "  無印 : [1/3] 構成確認（${WS} / Podfile）"
  echo "         [2/3] CocoaPods 導入状態確認（Pods/Manifest.lock）"
  echo "         [3/3] xcodebuild -workspace ${WS} -scheme ${SCHEME} -sdk iphonesimulator build"
  echo "               （Pods 未導入の場合は pod install が必要と表示して SKIP）"
  echo "  --full: [1/5] 構成確認 [2/5] Pods 導入状態確認"
  echo "         [3/5] pod install（リポ状態を変更する操作）"
  echo "         [4/5] xcodebuild build（同上コマンド）"
  echo "         [5/5] xcodebuild test（実在する iPhone シミュレータを検出して実行。"
  echo "               テストターゲットは雛形のみである点に注意）"
  finish
fi

if [ "$MODE" = "full" ]; then TOTAL=5; else TOTAL=3; fi

step "構成確認（${WS} / Podfile）"
HAS_WS=0
if [ -d "$WS" ] && [ -f "Podfile" ]; then
  HAS_WS=1
  ok "${WS} と Podfile が存在する"
elif [ ! -d "$WS" ]; then
  # workspace が無い場合は CocoaPods 導入からやり直す必要がある
  skip "${WS} が見つからない。pod install の実行が必要（--full が実行する）"
else
  skip "Podfile が見つからない（CocoaPods 構成の前提が崩れている）"
fi

step "CocoaPods 導入状態確認（Pods/Manifest.lock）"
PODS_READY=0
if [ -f "Pods/Manifest.lock" ]; then
  PODS_READY=1
  ok "Pods 導入済み（Pods/Manifest.lock あり）"
  if [ -f "Podfile.lock" ] && ! diff -q "Podfile.lock" "Pods/Manifest.lock" >/dev/null 2>&1; then
    info "Podfile.lock と Pods/Manifest.lock が不一致。pod install での更新が必要な可能性がある"
  fi
else
  info "Pods 未導入（Pods/Manifest.lock が無い）。workspace が参照する Pods/Pods.xcodeproj が存在せず build は失敗するため、pod install が必要（--full が実行する）"
fi

if [ "$MODE" = "fast" ]; then
  step "ビルド: xcodebuild -workspace ${WS} -scheme ${SCHEME} -sdk iphonesimulator build"
  if [ "$HAS_WS" -eq 0 ]; then
    skip "${WS} が無い"
  elif [ "$XCODEBUILD_OK" -eq 0 ]; then
    skip "xcodebuild が使用できない"
  elif [ "$PODS_READY" -eq 0 ]; then
    skip "Pods 未導入のためビルド不可。pod install が必要（無印はリポ状態を変更しないため --full で実行する）"
  else
    LOG=$(mktemp "${TMPDIR:-/tmp}/kozukaityou_verify_build.XXXXXX")
    echo "  実行中（ログ: ${LOG}）..."
    if xcodebuild -workspace "$WS" -scheme "$SCHEME" -sdk iphonesimulator build >"$LOG" 2>&1; then
      ok "ビルド成功"
    else
      echo "  --- ビルドログ末尾 ---"
      tail -n 40 "$LOG"
      fail "xcodebuild build が失敗した（全ログ: ${LOG}）"
    fi
  fi
  finish
fi

# --- --full 専用ステップ ---------------------------------------------
step "pod install（注意: Pods/ を生成・更新するリポ状態の変更操作）"
if [ ! -f "Podfile" ]; then
  skip "Podfile が無い"
elif ! have pod; then
  skip "pod（CocoaPods）が見つからない。gem install cocoapods 等での導入が必要"
else
  LOG=$(mktemp "${TMPDIR:-/tmp}/kozukaityou_verify_pod.XXXXXX")
  echo "  実行中（ログ: ${LOG}）..."
  if pod install >"$LOG" 2>&1; then
    ok "pod install 成功"
    PODS_READY=1
    HAS_WS=1
  else
    echo "  --- pod install ログ末尾 ---"
    tail -n 40 "$LOG"
    fail "pod install が失敗した（全ログ: ${LOG}）"
  fi
fi

step "ビルド: xcodebuild -workspace ${WS} -scheme ${SCHEME} -sdk iphonesimulator build"
BUILD_DONE=0
if [ "$HAS_WS" -eq 0 ] || [ ! -d "$WS" ]; then
  skip "${WS} が無い"
elif [ "$XCODEBUILD_OK" -eq 0 ]; then
  skip "xcodebuild が使用できない"
elif [ "$PODS_READY" -eq 0 ]; then
  skip "Pods 未導入のままのためビルド不可（pod install が SKIP または失敗）"
else
  LOG=$(mktemp "${TMPDIR:-/tmp}/kozukaityou_verify_build.XXXXXX")
  echo "  実行中（ログ: ${LOG}）..."
  if xcodebuild -workspace "$WS" -scheme "$SCHEME" -sdk iphonesimulator build >"$LOG" 2>&1; then
    ok "ビルド成功"
    BUILD_DONE=1
  else
    echo "  --- ビルドログ末尾 ---"
    tail -n 40 "$LOG"
    fail "xcodebuild build が失敗した（全ログ: ${LOG}）"
  fi
fi

step "テスト: xcodebuild test（iPhone シミュレータ）"
info "テストターゲット（KOZUKAITYOUTests / KOZUKAITYOUUITests）は雛形の空実装のみで、パスしても品質保証にはならない"
if [ "$BUILD_DONE" -eq 0 ]; then
  skip "ビルドが完了していないため test をスキップする"
elif ! have xcrun || ! xcrun simctl help >/dev/null 2>&1; then
  skip "xcrun simctl が使用できないためシミュレータを検出できない"
else
  # 実在するシミュレータ名を検出する（名前の推測はしない）。
  # 行例: "    iPhone SE (3rd generation) (0B1D...-...) (Shutdown)"
  # 末尾の UUID 括弧以降を落とし、機種名だけを取り出す。
  SIM_NAME=$(xcrun simctl list devices available 2>/dev/null \
    | grep "iPhone" | head -n 1 \
    | sed -E -e 's/^[[:space:]]*//' -e 's/ \([0-9A-Fa-f-]{36}\).*$//')
  if [ -z "$SIM_NAME" ]; then
    skip "利用可能な iPhone シミュレータが見つからない（Xcode でランタイムの導入が必要）"
  else
    LOG=$(mktemp "${TMPDIR:-/tmp}/kozukaityou_verify_test.XXXXXX")
    echo "  使用シミュレータ: ${SIM_NAME}"
    echo "  実行中（ログ: ${LOG}）..."
    if xcodebuild -workspace "$WS" -scheme "$SCHEME" \
      -destination "platform=iOS Simulator,name=${SIM_NAME}" test >"$LOG" 2>&1; then
      ok "xcodebuild test 成功（内容は雛形テストのみ）"
    else
      echo "  --- テストログ末尾 ---"
      tail -n 60 "$LOG"
      fail "xcodebuild test が失敗した（全ログ: ${LOG}）"
    fi
  fi
fi

finish
