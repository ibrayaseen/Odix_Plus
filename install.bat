
if exist Odix_Plus_test (
	  
	  git config --global --add safe.directory D:/Odix_Plus_test
	  cd D:\Odix_Plus_test
     git pull https://github.com/ibrayaseen/Odix_Plus.git
) else (
    git clone https://github.com/ibrayaseen/Odix_Plus.git Odix_Plus_test
)
pause

Odixpro@123