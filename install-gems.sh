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

scheme="https:"
gem_repo_authority_path="gem.fury.io/obsidian/"
public_gem_repo_uri="$scheme//$gem_repo_authority_path"

if [ -n "$OBSIDIAN_GEMFURY_SECRET" ]; then
  private_gem_repo_uri="$scheme//$OBSIDIAN_GEMFURY_SECRET@$gem_repo_authority_path"
  private_source="--source $private_gem_repo_uri"
fi

public_source="--source $public_gem_repo_uri"

ruby_gems_source="--source https://rubygems.org"

echo
echo "Installing gems locally (POSTURE: $POSTURE)"
echo '- - -'
for gem in *.gem; do
  echo "($gem)"
  cmd="gem install $gem --clear-sources $private_source $public_source $ruby_gems_source --install-dir ./gems"

  if [ operational != "$POSTURE" ]; then
    cmd="$cmd --development"
  fi

  echo $cmd
  ($cmd) || exit 1
done

echo '= = ='
echo '(done)'
echo
