# Available branches: Production, Development
localization_branch="Development"

if [ -n "$1" ]; then
    type=$1
    if [ $type == "release" ]; then
        localization_branch="Production"
    fi
fi

archive="localization_arb.tar"
projectId=$LOCALIZELY_PROJECT_ID
apiToken=$LOCALIZELY_PROJECT_API_TOKEN
url="https://api.localizely.com/v1/projects/$projectId/files/download?branch=$localization_branch&export_empty_as=main&type=flutter_arb"

echo "Downloading localization arb files from $localization_branch branch."
http_response=$(curl -X GET $url -H "accept: */*" -H "X-Api-Token: $apiToken" --output $archive -w "%{http_code}")

if [ $http_response != "200" ]; then
    echo "Error:"
    cat $archive
    exit 1
fi

echo "Unpacking archive."
tar -xvf $archive -C lib/l10n/arb
rm -rf archive

echo "Regenerating localization files."
fvm flutter --no-color pub run intl_utils:generate

echo 'Format'
fvm dart format -l 100 lib/l10n
