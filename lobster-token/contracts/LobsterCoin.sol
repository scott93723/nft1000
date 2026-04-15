// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LobsterCoin is ERC20, ERC20Permit, Ownable {
    uint256 public constant MAX_SUPPLY = 1_000_000_000 ether;

    uint256 public constant PUBLIC_SALE_ALLOCATION = (MAX_SUPPLY * 40) / 100;
    uint256 public constant STAKING_ALLOCATION = (MAX_SUPPLY * 20) / 100;
    uint256 public constant TEAM_ALLOCATION = (MAX_SUPPLY * 15) / 100;
    uint256 public constant AIRDROP_ALLOCATION = (MAX_SUPPLY * 15) / 100;
    uint256 public constant LIQUIDITY_ALLOCATION = (MAX_SUPPLY * 10) / 100;

    error ZeroAddress(string field);
    error InvalidAllocation();

    event AllocationMinted(string indexed bucket, address indexed to, uint256 amount);

    constructor(
        address initialOwner,
        address publicSaleWallet,
        address stakingRewardsWallet,
        address teamWallet,
        address airdropWallet,
        address liquidityWallet
    ) ERC20("Lobster Coin", "LOBSTER") ERC20Permit("Lobster Coin") Ownable(initialOwner) {
        if (initialOwner == address(0)) revert ZeroAddress("initialOwner");
        if (publicSaleWallet == address(0)) revert ZeroAddress("publicSaleWallet");
        if (stakingRewardsWallet == address(0)) revert ZeroAddress("stakingRewardsWallet");
        if (teamWallet == address(0)) revert ZeroAddress("teamWallet");
        if (airdropWallet == address(0)) revert ZeroAddress("airdropWallet");
        if (liquidityWallet == address(0)) revert ZeroAddress("liquidityWallet");

        uint256 totalAllocation = PUBLIC_SALE_ALLOCATION
            + STAKING_ALLOCATION
            + TEAM_ALLOCATION
            + AIRDROP_ALLOCATION
            + LIQUIDITY_ALLOCATION;

        if (totalAllocation != MAX_SUPPLY) revert InvalidAllocation();

        _mint(publicSaleWallet, PUBLIC_SALE_ALLOCATION);
        emit AllocationMinted("public_sale", publicSaleWallet, PUBLIC_SALE_ALLOCATION);

        _mint(stakingRewardsWallet, STAKING_ALLOCATION);
        emit AllocationMinted("staking_rewards", stakingRewardsWallet, STAKING_ALLOCATION);

        _mint(teamWallet, TEAM_ALLOCATION);
        emit AllocationMinted("team", teamWallet, TEAM_ALLOCATION);

        _mint(airdropWallet, AIRDROP_ALLOCATION);
        emit AllocationMinted("airdrop", airdropWallet, AIRDROP_ALLOCATION);

        _mint(liquidityWallet, LIQUIDITY_ALLOCATION);
        emit AllocationMinted("liquidity", liquidityWallet, LIQUIDITY_ALLOCATION);
    }
}
