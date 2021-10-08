#!/bin/bash

input() {
    python3 <<EOF
import os
import sys
VIRTUAL_ADDRESSES = [
    '0010 0100',
    '1000 0001',
    '0000 0101',
    '1100 1111',
    '0011 1100',
    '0001 1001',
]

with os.fdopen(sys.stdout.fileno(), 'wb') as fs:
    for virtual_address in VIRTUAL_ADDRESSES:
        virtual_address = virtual_address.replace(' ', '')
        virtual_address = int(virtual_address, 2)

        fs.write(virtual_address.to_bytes(1, byteorder='little'))
EOF
}

output() {
    cat <<EOF | base64 -d
VkFbMjRdIC0+IFBBWzU0XQpWQVs4MV0gLT4gUEFbMDFdIFNlZ21lbnRhdGlvbiBGYXVsdApWQVsw
NV0gLT4gUEFbMzVdClZBW2NmXSAtPiBQQVswZl0gU2VnbWVudGF0aW9uIEZhdWx0ClZBWzNjXSAt
PiBQQVsyY10gUHJvdGVjdGlvbiBGYXVsdApWQVsxOV0gLT4gUEFbNzldCg==
EOF
}

echo "Checking reading10 program ... "

DIFF=$(diff <(input | ./program 2> /dev/null) <(output) | grep -E "^[><]" | wc -l)
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
