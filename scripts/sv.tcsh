if (! -d $REPO_DIR/$1) then          
    echo "No such repo!"              
else                                  
    setenv REPO_NAME $1               
    setenv REPO_ROOT "$REPO_DIR/$1"  
    src                               
    # cd $REPO_ROOT                   
endif                                 
