#!/bin/bash

output() {
    cat <<EOF | base64 -d
L2Rldi9tZDEyNgpleHQ0CnJhaWQxCjMyRwoyNjIxNzcKMTE3NjA4Cg==
EOF
}

echo "Checking reading10 program ... "

DIFF=$(diff <(./program 2> /dev/null) <(output) | grep -E "^[><]" | wc -l)
SCORE=$(python3 <<EOF
print("{:0.2f} / 3.00".format((6 - $DIFF) * 3.0 / 6.0))
EOF
)
echo "   Score $SCORE"

if [ "$DIFF" -eq 0 ]; then
    echo "  Status Success"
else
    echo "  Status Failure"
fi

echo
exit $DIFF
