pragma solidity ^0.4.0;

contract Bank{
    
    ///////////////// ACCOUNTS HANDLERS ///////////////
    
    address[] name1; // To store names of account holder
    address[] name2; // To store names of 2nd account holder
    uint[] acc_no; // To store corrospinding account numbers
    uint[] bal; // To store corrospinding balances
    uint[] fd; // create an FD
    
    //////////////// VARIABLES & LIMITS ////////////////
    
    uint curr_acc_seq=1111; // Starting Account Number
    uint deposit_limit=1000; // Setting a deposit limit
    uint fund_transfer_limit = 500; // Setting fund transfer limit
    uint withdrawal_limit = 500; // Setting withdrawal limit
    uint minimum_balance = 100; // Setting minimum balance
    
    // FUNCTION FOR STRING COMPARISON
    function scomp (string a, string b) view returns (bool){
       return keccak256(a) == keccak256(b);
   }
    
    
    // CREATE SINGLE ACCOUNT -> CHANGED 
    function create_account() payable returns(uint) {
        if(msg.value>=minimum_balance){
            name1.push(msg.sender);
            name2.push(0);
            acc_no.push(curr_acc_seq);
            curr_acc_seq=curr_acc_seq+1;
            bal.push(msg.value);
            fd.push(0);
            return curr_acc_seq-1; 
        }
        else{
            return 0;
        }
    }
    
    // DELETE SINGLE ACCOUNT -> CHANGED
    function delete_account(uint account_no) returns(bool) {
        uint arrayLength = acc_no.length;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no && name1[i]==msg.sender){
                    acc_no[i]=999;
                    return true;
                }
            }
            return false;
    }
    
    // DELETE JOINT ACCOUNT -> CHANGED
    
    function delete_account(uint account_no,address a1, address a2) returns(bool) {
        uint arrayLength = acc_no.length;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no && name1[i]==msg.sender && a1 == name1[i] && name2[i]==a2){
                    acc_no[i]=999;
                    return true;
                }
            }
            return false;
    }
    
    // CREATE JOINT ACCOUNT -> CHANGED
    function create_joint_account(address name_1, address name_2) payable returns(uint) {
        if(msg.value>=minimum_balance){
            name1.push(name_1);
            name2.push(name_2);
            acc_no.push(curr_acc_seq);
            bal.push(msg.value);
            curr_acc_seq=curr_acc_seq+1;
            fd.push(0);
            return curr_acc_seq-1; 
        }
        else{
            return 0;
        }
    }
    
    // FUND DEPOSIT -> CHANGED
    function deposit(uint account_no) payable returns(uint){
        if(msg.value <=deposit_limit){
            uint arrayLength = acc_no.length;
            uint done = 0;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no){
                    done =bal[i]+msg.value;
                    bal[i]=bal[i]+msg.value;
                }
            }
            return done;
        }
        else{
            return 0;
        }
    }
    
    // FUND WITHDRAW -> CHANDED
    function withdraw(uint account_no, uint amount)returns(uint){
        if(amount <=withdrawal_limit){
            uint arrayLength = acc_no.length;
            uint done = 0;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no && (name1[i]==msg.sender || name2[i]==msg.sender)){
                    done =bal[i]-amount;
                    if(done>minimum_balance){
                        bal[i]=bal[i]-amount;
                    }
                    else{
                        done=0;
                    }
                }
            }
            return done;
        }
        else{
            return 0;
        }
    }
    
    // SEE BALANCE -> CHANGED
    function check_bal(uint account_no) returns(uint){
          uint arrayLength = acc_no.length;
          for (uint i=0; i<arrayLength; i++) {
            if(acc_no[i]==account_no && (name1[i]==msg.sender || name2[i]==msg.sender))
                return bal[i];
            }
            return 0;
              
         }
         
    // FUNDS TRANSFER -> CHANGED
        function transfer_funds(uint acc1, uint acc2, uint amount)returns (bool){
            var found = 0;
            if(amount<=fund_transfer_limit){
                 uint arrayLength = acc_no.length;
                    for (uint i=0; i<arrayLength; i++) {
                        if(acc_no[i]==acc2){
                            found =1;
                        }
                    }
                ///////////////////////
                if(amount <=withdrawal_limit){
                arrayLength = acc_no.length;
                uint done = 0;
                for ( i=0; i<arrayLength; i++) {
                if(acc_no[i]==acc1 && (name1[i]==msg.sender || name2[i]==msg.sender)){
                    done =bal[i]-amount;
                    if(done>minimum_balance){
                        done =1;
                    }
                    else{
                        done=0;
                    }
                }
            }
           var rec= done;
        }
        else{
            rec=0;
        }
                ///////////////////////
                if(rec==0 || found ==0){
                    return false;
                }
                else{
                    
                    arrayLength = acc_no.length;
                    for ( i=0; i<arrayLength; i++) {
                        if(acc_no[i]==acc1 && (name1[i]==msg.sender || name2[i]==msg.sender)){
                            bal[i]=bal[i]-amount;
                        }
                    }
                    for ( i=0; i<arrayLength; i++) {
                        if(acc_no[i]==acc2){
                            bal[i]=bal[i]+amount;
                            return true;
                            }
                        }
                    }
                }
            }
        
    
    
    // DONE CREATE FD
    function create_fd(uint account_no) payable returns(bool){
        
         uint arrayLength = acc_no.length;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no && (name1[i]==msg.sender || name2[i]==msg.sender)){
                    fd[i]=fd[i]+msg.value;
                    return true;
                }
            }
            return false;
    }
    
    // DONE REDEEM FD
    function redeem_fd(uint account_no) returns(uint){
        
         uint arrayLength = acc_no.length;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no && (name1[i]==msg.sender || name2[i]==msg.sender)){
                    var a = fd[i];
                    fd[i]=0;
                    return a;
                }
            }
            return 0;
    }
    
    
    
    
    
}
