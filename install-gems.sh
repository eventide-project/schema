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

echo
echo 'Installing gems locally'
echo '- - -'
for gem in *.gem; do
  echo "($gem)"
  gem install $gem --source https://gem.fury.io/obsidian/ --install-dir ./gems --development
done

echo '= = ='
echo '(done)'
echo
