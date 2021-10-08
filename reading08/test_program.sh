#!/bin/bash

output() {
    cat <<EOF | base64 -d
bWVtb3J5IGxlYWsKdW5pbml0aWFsaXplZCByZWFkCnNlZ2ZhdWx0CmludmFsaWQgZnJlZQpidWZm
ZXIgb3ZlcmZsb3cK
EOF
}

echo "Checking reading08 program ... "

DIFF=$(diff <(./program 2> /dev/null) <(output) | grep -E "^[><]" | wc -l)
COUNT=$(output | wc -l)
SCORE=$(python3 <<EOF
print("{:0.2f} / 3.00".format(($COUNT - $DIFF) * 3.0 / $COUNT.0))
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
