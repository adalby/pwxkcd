case ${1} in
  [0-9]) WORDS=${1}
         echo "generate "${WORDS}" words";; 
  *)     WORDS=1 
         echo "This script will prompt you for a dozen coin flips."
         echo "It will then output the 12 bit binary number"
         echo "and a memorable word corresponding to that number"
         echo "for use in an xkcd style password."
         echo 
         echo "Pass it a number to generate that many words"
         echo "  i.e. <./pick.sh 6> to pick 6 words.";;
esac

for j in $(seq 1 ${WORDS}); do
  for i in $(seq 1 12); do
    echo $((i*j)) of $((12*${WORDS}))
    select FLIP in "Heads" "Tails"; do
      case ${FLIP} in
        "Heads") RAND=${RAND}0; break;;
        "Tails") RAND=${RAND}1; break;;
      esac
    done
  done
done

for PICK in $(echo ${RAND}|fold -b12); do 
  PASS=${PASS}" "$(sed $((2#${PICK}+1))'q;d' word.list)
done
echo ${RAND}
echo ${PASS}
