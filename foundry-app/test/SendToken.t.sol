// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";

// ERC-20 interface for interacting with the USDC token
interface IERC20 {
    function balanceOf(address) external view returns (uint256);
    function transfer(address, uint256) external returns (bool);
    function decimals() external view returns (uint8);
}

// TokenTransferTest is a contract that sets up and runs the test
contract TokenTransferTest is Test {
    IERC20 usdc; // Interface instance for USDC
    address whale = 0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf; // Polygon's ERC20 Bridge contract address on Ethereum Mainnet, used as a whale account
    address recipient = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045; // Vitalik's (vitalik.eth) address, used as the recipient
    address usdcAddress = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; // USDC contract address on Ethereum Mainnet

    // setUp function runs before each test, setting up the environment
    function setUp() public {
        usdc = IERC20(usdcAddress); // Initialize the USDC contract interface

        // Impersonate the whale account for testing
        vm.startPrank(whale);
    }

    // testTokenTransfer function tests the transfer of USDC from the whale account to the recipient
    function testTokenTransfer() public {
        uint256 initialBalance = usdc.balanceOf(recipient); // Get the initial balance of the recipient
        uint8 decimals = usdc.decimals(); // Get the decimal number of USDC
        uint256 transferAmount = 1000000 * 10 ** decimals; // Set the amount of USDC to transfer (1 million tokens, with 6 decimal places)

        console.log("Recipient's initial balance: ", initialBalance); // Log the initial balance to the console

        // Perform the token transfer from the whale to the recipient
        usdc.transfer(recipient, transferAmount);

        uint256 finalBalance = usdc.balanceOf(recipient); // Get the final balance of the recipient

        console.log("Recipient's final balance: ", finalBalance); // Log the final balance to the console

        // Verify that the recipient's balance increased by the transfer amount
        assertEq(finalBalance, initialBalance + transferAmount, "Token transfer failed");

        vm.stopPrank(); // Stop impersonating the whale account
    }
}