# Author: S. Schwalbe 
# Date: 29.04.2019 
# you might need to change the paths according to your needs
fodmc="$(dirname "$(pwd)")"
echo $fodmc
cp $fodmc/src/xx_database_xx . 
$fodmc/src/fodMC
