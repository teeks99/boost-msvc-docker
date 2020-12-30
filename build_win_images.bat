
set datestr=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
echo %datestr% > lastBuildDate.txt

for %%v in ( 14.0 14.1 14.2 ) do (
  pushd %%v
  docker build -t teeks99/boost-msvc:%%v_%datestr% -m 2g .
  docker tag teeks99/boost-msvc:%%v_%datestr% teeks99/boost-msvc:%%v
  popd
)

docker tag teeks99/boost-msvc:14.2 teeks99/boost-msvc:latest