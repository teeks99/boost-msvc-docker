
for %%v in ( 14.2 ) do (
  pushd %%v
  docker build -t teeks99/boost-msvc:%%v -m 2g .
  popd
)