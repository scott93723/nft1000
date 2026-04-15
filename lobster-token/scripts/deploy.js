const hre = require("hardhat");
require("dotenv").config();

function required(name) {
  const value = process.env[name];
  if (!value) throw new Error(`缺少環境變數：${name}`);
  return value;
}

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with:", deployer.address);
  console.log("Network:", hre.network.name);

  const LobsterCoin = await hre.ethers.getContractFactory("LobsterCoin");
  const token = await LobsterCoin.deploy(
    required("INITIAL_OWNER"),
    required("PUBLIC_SALE_WALLET"),
    required("STAKING_REWARDS_WALLET"),
    required("TEAM_WALLET"),
    required("AIRDROP_WALLET"),
    required("LIQUIDITY_WALLET")
  );

  await token.waitForDeployment();
  const address = await token.getAddress();

  console.log("Lobster Coin deployed to:", address);
  console.log("Token name:", await token.name());
  console.log("Token symbol:", await token.symbol());
  console.log("Total supply:", String(await token.totalSupply()));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
