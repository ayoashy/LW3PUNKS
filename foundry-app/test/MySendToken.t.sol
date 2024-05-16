// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";

interface IERC20 {
function balanceOf(address) external view returns(uint256);

function transfer(address, uint256) external returns (bool);

function decimal() external view returns (uint8);

}


contract TestTransfer is Test {
 IERC20 usd;

 address recipient = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;
 address whale = 0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf;
 address usdAddress = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

 function setup() public {
  usd = IERC20(usdAddress);

  vm.startPrank(whale);
 }

 function testTransfer() public {
  uint256 initialBalance = usd.balanceOf(recipient);

  uint8 decimal = usd.decimal();

  uint256 transferAmount = 1000000 * 10 ** decimal;

  console.log("initial balance", initialBalance);

  usd.transfer(recipient, transferAmount);

  uint256 endingBalance = usd.balanceOf(recipient);

  console.log("ending balance", endingBalance);

  assertEq(endingBalance, initialBalance + transferAmount, "function failed!");

  vm.stopPrank();
 }

}