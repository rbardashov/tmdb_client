echo 'Start clean'

echo 'Format'
fvm dart format -l 100 lib

echo 'Import sort'
fvm flutter pub run import_sorter:main

echo 'Finish clean'
