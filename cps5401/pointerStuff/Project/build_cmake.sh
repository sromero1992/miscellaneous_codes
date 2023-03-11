BDIR=build
PROG=test_rf
if [ ! -d ${BDIR} ]
then
  mkdir ${BDIR}
fi

cd ${BDIR}
cmake ../
make
cp ${PROG} ../
cd ../
