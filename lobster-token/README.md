# Lobster Coin ($LOBSTER)

這是龍蝦幣的 ERC-20 合約工作區。

## 規格
- 名稱：Lobster Coin
- 代號：LOBSTER
- 總供應量：1,000,000,000
- 鏈：Polygon（建議先測試網 Amoy）

## 分配
- 40% 公開銷售
- 20% 質押獎勵
- 15% 開發團隊
- 15% 社群空投
- 10% 流動性池

## 安全原則
- 使用 OpenZeppelin 標準 ERC20 + ERC20Permit + Ownable
- 固定總量，部署時一次性鑄造完畢
- 不提供部署後額外增發

## 安裝
```bash
cd lobster-token
npm install
```

## 編譯
```bash
npm run compile
```

## 部署前準備
```bash
cp .env.example .env
```
把以下地址填入：
- INITIAL_OWNER
- PUBLIC_SALE_WALLET
- STAKING_REWARDS_WALLET
- TEAM_WALLET
- AIRDROP_WALLET
- LIQUIDITY_WALLET

## 先部署測試網
```bash
npm run deploy:amoy
```

## 再部署主網
```bash
npm run deploy:polygon
```

## 建議
- TEAM 建議不要直接用一般錢包，改用多簽或 vesting 合約
- 正式主網前先做測試 + 審查
- 不要把真私鑰提交到 GitHub
