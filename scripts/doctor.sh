#!/data/data/com.termux/files/usr/bin/bash

echo "================================="
echo " Termux Bootstrap Doctor"
echo "================================="

echo

PASS=0
WARN=0
FAIL=0

check_ok() {
    echo "[OK] $1"
    PASS=$((PASS+1))
}

check_warn() {
    echo "[WARN] $1"
    WARN=$((WARN+1))
}

check_fail() {
    echo "[FAIL] $1"
    FAIL=$((FAIL+1))
}

echo "Checking Termux environment..."

if [ -n "$PREFIX" ] && [ -d "$PREFIX" ]; then
    check_ok "Termux environment detected"
else
    check_fail "Not running inside Termux"
fi


echo
echo "Checking required commands..."

for cmd in git gh curl python ssh; do

    if command -v "$cmd" >/dev/null 2>&1; then
        check_ok "$cmd installed"
    else
        check_warn "$cmd missing"
    fi

done


echo
echo "Checking Git configuration..."

GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
    check_ok "Git identity configured"
else
    check_warn "Git identity not configured"
fi


echo
echo "Checking storage permission..."

if [ -d "/storage/emulated/0" ]; then
    check_ok "Storage accessible"
else
    check_warn "Storage permission not available"
fi


echo
echo "Checking network..."

if curl -fs https://github.com >/dev/null 2>&1; then
    check_ok "Internet connectivity available"
else
    check_warn "Internet connectivity check failed"
fi


echo

echo "================================="
echo " Summary"
echo "================================="

echo "Passed: $PASS"
echo "Warnings: $WARN"
echo "Failures: $FAIL"
