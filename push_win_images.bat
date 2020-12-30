set datestr=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

if exist lastBuildDate.txt (
  set /p datestr=<lastBuildDate.txt
)

for %%v in ( 14.0 14.1 14.2 ) do (
  docker push teeks99/boost-msvc:%%v_%datestr%
  docker push teeks99/boost-msvc:%%v
)

docker push teeks99/boost-msvc:latest
