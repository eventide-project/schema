echo
echo 'Installing local gems'
echo '= = ='

source ./set-local-gem-path.sh

echo
echo 'Removing gem files'
echo '- - -'
for gem in *.gem; do
  echo "- $gem"
  rm $gem
done

echo
echo 'Building gems'
echo '- - -'
for gemspec in *.gemspec; do
  echo "- $gemspec"
  gem build $gemspec
done

if [ -z ${POSTURE+x} ]; then
  POSTURE="operational"
fi

echo
echo "Installing gems locally (POSTURE: $POSTURE)"
echo '- - -'
for gem in *.gem; do
  echo "($gem)"
  cmd="gem install $gem --source https://gem.fury.io/obsidian/ --install-dir ./gems"

  if [ operational != "$POSTURE" ]; then
    cmd="$cmd --development"
  fi

  echo $cmd
  ($cmd)
done

echo '= = ='
echo '(done)'
echo
