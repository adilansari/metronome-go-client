IN_FILE=$1

main() {
  cat $IN_FILE | jq .components.parameters
}

main