// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TokenCid {
  
    string public name = "TokenCid";
    address  payable public owner;
    uint256  numbOfTokens0;
    
    constructor() payable {
        mint(msg.sender, 0, 1000000);
        owner = payable(msg.sender);
          }
    
    mapping (address=>mapping(uint256 =>uint256)) balance;// check balance
    mapping (address => mapping(string=>string)) _checkerCid;//store cid
    event TransferSingle(address _adm, address _from, address _to, uint256 _id, uint256 _value);
    event TransferCid (address from , address to ,string idCid);
//mint
 function mint(address to,uint256 id,uint256 amount) private{
    balance[to][id] += amount;
 }
//transfer
function safeTransferFrom ( address _from,address _to, uint256 _id, uint256 _value)  private {
    if (_to == address(0))
    { revert("this address is no permit");}
    if (_value > balance[_from][_id])
    {revert("balance is low");}
     require ( _from != address(0) , "from address cannot be default null address");
      balance[_from][_id] = balance[_from][_id] - _value;
      balance[_to][_id] = balance[_to][_id] + _value;
     emit TransferSingle(owner,_from,_to,_id,_value);
       }
//balance
   function balanceOf(address _onwer) public view returns (uint256) {
        require(_onwer != address(0), "ERC1155: address zero is not a valid owner");
        return balance[_onwer][0];
    }
    
 //buy and transfer token
   receive() external payable {
         require(msg.value == 1 ether, "cannot deposit below 1 ether");
          owner.transfer(msg.value) ;
         numbOfTokens0 = ((msg.value/1000000000000000000) *5);
          safeTransferFrom(owner,msg.sender, 0,numbOfTokens0);
            }

  
 //store cid file and identity or name
    function setCid(address _owner,string memory _idCid,string memory _cid) public {
           require(balance[msg.sender][0]>0,"your balance is low");
           balance[msg.sender][0] = balance[msg.sender][0] - 1;
        _checkerCid[_owner][_idCid] = _cid;
    }
 // get cid file with it identity
    function getCid(address _owner,string memory _idCid) public view returns (string memory ) {
        return _checkerCid[_owner][_idCid];
    }                                           
     
  function transferCid(address _from,address _to,string memory _idCid) public returns(bool){
       string memory tempo = _checkerCid[_from][_idCid];
       _checkerCid[_to][_idCid] = tempo;
       _checkerCid[_from][_idCid] = " ";
       emit TransferCid(_from , _to , _idCid);
       return true;
     }
     }
   

