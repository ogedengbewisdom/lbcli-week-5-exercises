# Create a CLTV script with a timestamp of 1495584032 and public key below:
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277


# Get the equivalent LE HEx of timestamp 1495584032
hex=$(printf '%08x\n' 1495584032 | sed 's/^\(00\)*//'); 

lehex=$(echo $hex | tac -rs .. | echo "$(tr -d '\n')");

size=$(echo -n $lehex | wc -c | awk '{print $1/2}')

PUBKEY_HASH=$(echo $publicKey | xxd -r -p | openssl sha256 -binary | openssl rmd160 | cut -d' ' -f2)


script="0$size"$lehex"b17576a914"$PUBKEY_HASH"88ac"

echo $script