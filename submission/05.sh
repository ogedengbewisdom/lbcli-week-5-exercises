# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
block_height=150

hex=$(printf '%08x\n' $block_height | sed 's/^\(00\)*//'); 

numberonehex=$(echo $hex| cut -c1)

[[ 0x$numberonehex -gt 0x7 ]] && hex="00"$hex

lehex=$(echo $hex | tac -rs .. | echo "$(tr -d '\n')");


size=$(echo -n $lehex | wc -c | awk '{print $1/2}') # two digits

pubkey_hash=$(echo $publicKey | xxd -r -p | openssl sha256 -binary | openssl rmd160 | cut -d' ' -f2)

csv_script="0$size"$lehex"b27576a914"$pubkey_hash"88ac"

echo $csv_script