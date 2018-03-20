pragma solidity ^0.4.0;

contract Bank{
    
    ///////////////// ACCOUNTS HANDLERS ///////////////
    
    string[] name1; // To store names of account holder
    string[] name2; // To store names of 2nd account holder
    uint[] acc_no; // To store corrospinding account numbers
    uint[] bal; // To store corrospinding balances
    
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
    
    
    // CREATE SINGLE ACCOUNT
    function create_account(string name, uint amount) returns(uint) {
        if(amount>=minimum_balance){
            name1.push(name);
            name2.push("NULL");
            acc_no.push(curr_acc_seq);
            curr_acc_seq=curr_acc_seq+1;
            bal.push(amount);
            return curr_acc_seq-1; 
        }
        else{
            return 0;
        }
    }
    
    // DELETE SINGLE ACCOUNT
    function delete_account(uint account_no) returns(bool) {
        uint arrayLength = acc_no.length;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no){
                    acc_no[i]=999;
                    return true;
                }
            }
            return false;
    }
    
    // CREATE JOINT ACCOUNT
    function create_joint_account(string name_1, string name_2, uint amount) returns(uint) {
        if(amount>=minimum_balance){
            name1.push(name_1);
            name2.push(name_2);
            acc_no.push(curr_acc_seq);
            bal.push(amount);
            curr_acc_seq=curr_acc_seq+1;
            return curr_acc_seq-1; 
        }
        else{
            return 0;
        }
    }
    
    // FUND DEPOSIT 
    function deposit(uint account_no, uint amount)returns(uint){
        if(amount <=deposit_limit){
            uint arrayLength = acc_no.length;
            uint done = 0;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no){
                    done =bal[i]+amount;
                    bal[i]=bal[i]+amount;
                }
            }
            return done;
        }
        else{
            return 0;
        }
    }
    
    // FUND DEPOSIT 
    function withdraw(uint account_no, uint amount)returns(uint){
        if(amount <=withdrawal_limit){
            uint arrayLength = acc_no.length;
            uint done = 0;
            for (uint i=0; i<arrayLength; i++) {
                if(acc_no[i]==account_no){
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
    
    // SEE BALANCE
    function check_bal(uint account_no) returns(uint){
          uint arrayLength = acc_no.length;
          for (uint i=0; i<arrayLength; i++) {
            if(acc_no[i]==account_no)
                return bal[i];
            }
            return 0;
              
         }
         
    // FUNDS TRANSFER
    function transfer_funds(uint acc1, uint acc2, uint amount)returns (bool){
        if(amount<=fund_transfer_limit){
            uint rec = withdraw(acc1,amount);
            if(rec==0){
                return false;
            }
            else{
                rec = deposit(acc2, amount);
                if(rec==0){
                    deposit(acc1,amount);
                    return false;
                }
                return true;
            }
        }
    }
    
}
