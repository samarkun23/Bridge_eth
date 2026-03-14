pragma solidity ^0.8.13;
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract BrigeETH is Ownable {
    uint256 public balance;
    address public tokenAddress;

    event Deposit(address indexed depositor, uint amount);

    mapping(address => uint256)  public pendingBalance;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    function deposit(IERC20 _tokenAddress , uint256 _amount) public { // this IERC20 is the type/interface
        require(address(_tokenAddress) == tokenAddress);
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount);
        require(_tokenAddress.transferFrom(msg.sender, address(this), _amount)); // get Shinu coin from people
        emit Deposit(msg.sender, _amount);
    }

    function withdraw(IERC20 _tokenAddress , uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount); // Send it to back to the people
    }

    function burnedOnOtherSide(address userAccount , uint256 _amount) public onlyOwner{
        pendingBalance[userAccount] += _amount;
    }

}