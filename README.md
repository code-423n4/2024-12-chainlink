
# Chainlink audit details
- Total Prize Pool: $100,000 in USDC
  - HM awards: $80,700 in USDC
  - QA awards: $3,300 in USDC
  - Judge awards: $9,500 in USDC
  - Validator awards: $6,000 in USDC 
  - Scout awards: $500 in USDC
- [Read our guidelines for more details](https://docs.code4rena.com/roles/wardens)
- Starts December 6, 2024 20:00 UTC
- Ends January 3, 2025 20:00 UTC

**Note re: risk level upgrades/downgrades**

Two important notes about judging phase risk adjustments: 
- High- or Medium-risk submissions downgraded to Low-risk (QA)) will be ineligible for awards.
- Upgrading a Low-risk finding from a QA report to a Medium- or High-risk finding is not supported.

As such, wardens are encouraged to select the appropriate risk level carefully during the submission phase.

## Automated Findings / Publicly Known Issues

- **Uniswap swapping strategy:** we acknowledge that the current swapping strategy is not the most efficient one (e.g. we could improve it with smart order routing). The current option to use fixed path swaps instead of smart order routing / DEX Aggregation was an intentional design choice to limit the swap strategies to a permissionless DEX option with minimal off-chain requirements.
- **MEV that results in increased slippage:** we acknowledge that there is an inherent risk of the pools being MEV’ed in such a way that the swaps result in higher slippages than anticipated, which could lead to trade reverts. As long as the successful swaps are below our maximum tolerable slippage, MEV pushing to upper bound should not be considered a loss of funds. (e.g. for 0.5% slippage tolerances, it is tolerable to execute at 0.5% instead of 0.2% in the worst case scenario)
- **Delays between checkUpkeep and performUpkeep execution:** we acknowledge the risk, and will mitigate it by the deadline delay, max deviation and slippage parameters. The contract’s performUpkeep execution assumes that the inputs might be stale.
No recomputation of checkUpkeep data in performUpkeep: the performUpkeep function performs some critical checks, such as the check against maxPriceDeviation to protect against swaps that result in significantly lower swap results. However, we chose not to perform less critical validations (e.g. USD value of an asset being swapped within min-max USD swap size bounds) to save on gas costs & reduce complexity.
- **Malicious token processing:** all tokens will be vetted before onboarding them to the system. Malicious tokens are not a concern. Due to all tokens being reviewed, upgradability / pausability / blocklists / balance modifications / fee token transfers are out of scope.
- **Swapping optimization by utilising intermediate L2 routes:** for the current iteration, swaps will only occur on one network.
- **Gas optimizations for checkUpkeep:** the function is executed off-chain, gas optimizations will not have significant improvements
- **Maximum swap gas controls:** maximum gas thresholds will be controlled via Chainlink Automation’s [max gas threshold functionality](https://docs.chain.link/chainlink-automation/guides/gas-price-threshold#set-the-maximum-gas-price-on-an-existing-upkeep)
- **Re-entrancy in the Reserves contract:** the withdraw functionality in the Reserves contract will only allow withdrawing to allowlisted providers, and will use the LINK token, so there are no concerns for re-entrancy due to trust assumptions.
- **Negative balances for earmarks:** In rare circumstances, service providers may have negative balances in the Reserves contract, for scenarios when earmarks need to be retroactively adjusted. We acknowledge the risk of delisting a service provider with negative balances, where we may not resolve the negative LINK balance.
- **Swaps might not be executed due to spread between feed prices & Uniswap prices:** we acknowledge that some swaps might revert due to the differences between Chainlink Data Feed and Uniswap pool prices. This decision was made by design to execute trades against Chainlink Data Feed prices as the source of truth.
- **Exploits of dependencies:** malicious exploits on dependent protocols that are outside of the control of the system, e.g., an exploit in a Uniswap V3 liquidity pool contract.
- **In-depth validations for swap params:** asset swap path & the oracle being a correct Chainlink Data Feed address is validated off-chain

The 4naly3er report can be found [here](https://github.com/code-423n4/2024-12-chainlink/blob/main/4naly3er-report.md).

_Note for C4 wardens: Anything included in this `Automated Findings / Publicly Known Issues` section is considered a publicly known issue and is ineligible for awards._

# Overview

Payment Abstraction is a system of onchain smart contracts that aim to reduce payment friction and simplify billing for users and developers interacting with Chainlink services. The system is designed to (1) accept fees in various tokens across multiple blockchain networks, (2) consolidate fee tokens onto a single blockchain network via Chainlink CCIP, (3) convert fee tokens into LINK via Chainlink Automation, Price Feeds, and existing Automated Market Maker (AMM) Decentralized Exchange (DEX) contracts, and (4) pass converted LINK into a dedicated contract for withdrawal by Chainlink Network service providers.

## Links

- **Previous audits:** none
- **Documentation:** see [the following document](https://docs.google.com/document/d/1mCBE8bGV1WK0LPMPW5NZhF7BqSwoxJkZyJ1lDkQ39aY/edit?usp=sharing)
- **Website:** https://chain.link/
- **X/Twitter:** https://twitter.com/chainlink

---


# Scope

*See [scope.txt](https://github.com/code-423n4/2024-12-chainlink/blob/main/scope.txt)*

### Files in scope


| File   | Logic Contracts | Interfaces | nSLOC | Purpose | Libraries used |
| ------ | --------------- | ---------- | ----- | -----   | ------------ |
| /src/EmergencyWithdrawer.sol | 1| **** | 37 | |src/PausableWithAccessControl.sol<br>src/libraries/Errors.sol<br>@openzeppelin/contracts/interfaces/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol|
| /src/FeeAggregator.sol | 1| **** | 261 | |@openzeppelin/contracts/access/IAccessControl.sol<br>@openzeppelin/contracts/access/extensions/IAccessControlDefaultAdminRules.sol<br>@openzeppelin/contracts/access/extensions/IAccessControlEnumerable.sol<br>@openzeppelin/contracts/token/ERC20/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/utils/introspection/IERC165.sol<br>src/EmergencyWithdrawer.sol<br>src/PausableWithAccessControl.sol<br>src/interfaces/IFeeAggregator.sol<br>src/libraries/EnumerableBytesSet.sol<br>src/libraries/Errors.sol<br>src/libraries/Roles.sol<br>@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol<br>@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IAny2EVMMessageReceiver.sol<br>@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol<br>@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol<br>@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol<br>@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol<br>@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol<br>@openzeppelin/contracts/utils/structs/EnumerableSet.sol|
| /src/FeeRouter.sol | 1| **** | 69 | |src/interfaces/IFeeAggregator.sol<br>src/EmergencyWithdrawer.sol<br>src/libraries/Errors.sol<br>src/libraries/Roles.sol<br>@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol<br>@openzeppelin/contracts/token/ERC20/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/utils/introspection/IERC165.sol|
| /src/PausableWithAccessControl.sol | 1| **** | 52 | |src/interfaces/IPausable.sol<br>src/libraries/Roles.sol<br>@openzeppelin/contracts/access/extensions/AccessControlDefaultAdminRules.sol<br>@openzeppelin/contracts/access/extensions/IAccessControlEnumerable.sol<br>@openzeppelin/contracts/utils/Pausable.sol<br>@openzeppelin/contracts/utils/structs/EnumerableSet.sol|
| /src/Reserves.sol | 1| **** | 133 | |src/EmergencyWithdrawer.sol<br>src/libraries/Errors.sol<br>src/libraries/Roles.sol<br>@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol<br>@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol<br>@chainlink/contracts/src/v0.8/shared/token/ERC677/IERC677Receiver.sol<br>@openzeppelin/contracts/interfaces/IERC20.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/utils/structs/EnumerableSet.sol|
| /src/SwapAutomator.sol | 1| **** | 373 | |src/interfaces/IFeeAggregator.sol<br>src/FeeAggregator.sol<br>src/PausableWithAccessControl.sol<br>src/libraries/Errors.sol<br>src/libraries/Roles.sol<br>@aave/core-v3/contracts/protocol/libraries/math/PercentageMath.sol<br>@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol<br>@chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol<br>@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol<br>@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol<br>@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol<br>@openzeppelin/contracts/interfaces/IERC20.sol<br>@openzeppelin/contracts/interfaces/IERC20Metadata.sol<br>@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol<br>@openzeppelin/contracts/utils/math/Math.sol<br>@openzeppelin/contracts/utils/math/SafeCast.sol<br>@uniswap/swap-router-contracts/contracts/interfaces/IV3SwapRouter.sol<br>@uniswap/v3-periphery/contracts/interfaces/IQuoterV2.sol|
| /src/interfaces/IFeeAggregator.sol | ****| 1 | 3 | ||
| /src/interfaces/IPausable.sol | ****| 1 | 3 | ||
| /src/libraries/EnumerableBytesSet.sol | 1| **** | 68 | ||
| /src/libraries/Errors.sol | 1| **** | 33 | ||
| /src/libraries/Roles.sol | 1| **** | 10 | ||
| **Totals** | **9** | **2** | **1042** | | |

### Files out of scope

*See [out_of_scope.txt](https://github.com/code-423n4/2024-12-chainlink/blob/main/out_of_scope.txt)*



## Scoping Q &amp; A

| Question                                | Answer                       |
| --------------------------------------- | ---------------------------- |
| ERC20 used by the protocol              |       Any, including ERC-677 (LINK). See ERC20 token behaviour table.             |
| Test coverage                           | 100.00% (407/407 of lines)                          |
| ERC721 used  by the protocol            |       None              |
| ERC777 used by the protocol             |       None                |
| ERC1155 used by the protocol            |       None            |
| Chains the protocol will be deployed on | Ethereum,Arbitrum,Avax,Base,BSC,Optimism,Polygon,OtherAny EVM chain, including L2s. The contestants should not consider zkEVM chains and other EVM-like chains (such as TRX).

### ERC20 token behaviors in scope

| Question                                                                                                                                                   | Answer |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| [Missing return values](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#missing-return-values)                                                      |   In scope  |
| [Fee on transfer](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#fee-on-transfer)                                                                  |  Out of scope  |
| [Balance changes outside of transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#balance-modifications-outside-of-transfers-rebasingairdrops) | Out of scope    |
| [Upgradeability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#upgradable-tokens)                                                                 |   Out of scope  |
| [Flash minting](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#flash-mintable-tokens)                                                              | In scope    |
| [Pausability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#pausable-tokens)                                                                      | Out of scope    |
| [Approval race protections](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#approval-race-protections)                                              | In scope    |
| [Revert on approval to zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-approval-to-zero-address)                            | In scope    |
| [Revert on zero value approvals](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-approvals)                                    | In scope    |
| [Revert on zero value transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                    | In scope    |
| [Revert on transfer to the zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-transfer-to-the-zero-address)                    | In scope    |
| [Revert on large approvals and/or transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-large-approvals--transfers)                  | In scope    |
| [Doesn't revert on failure](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#no-revert-on-failure)                                                   |  In scope   |
| [Multiple token addresses](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                          | Out of scope    |
| [Low decimals ( < 6)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#low-decimals)                                                                 |   In scope  |
| [High decimals ( > 18)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#high-decimals)                                                              | In scope    |
| [Blocklists](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#tokens-with-blocklists)                                                                | Out of scope    |

### External integrations (e.g., Uniswap) behavior in scope:

| Question                                                  | Answer |
| --------------------------------------------------------- | ------ |
| Enabling/disabling fees (e.g. Blur disables/enables fees) | Yes   |
| Pausability (e.g. Uniswap pool gets paused)               |  Yes   |
| Upgradeability (e.g. Uniswap gets upgraded)               |   Yes  |


### EIP compliance checklist

- EIP-20: All tokens used within the contracts should implement the ERC20 standard, and expose a working decimals() function. (Accepted tokens will be pre-reviewed)
- EIP-165: All contracts should adhere to ERC-165. supportsInterface functionality should only be added for interfaces where on-chain interactions are expected, as opposed to every interface.
- EIP-677: Contracts which can receive LINK from other contracts (via a token push model) should support receiving LINK via transferAndCall. The contracts should ignore the data.



# Additional context

## Main invariants

- **SwapAutomator:** Swaps are only executed when outputAmountInUSDValue >= inputAmountInUSDValue * (1 - maxDeviation), where the USD value is determined from the Chainlink Data Feeds. Swaps that do not meet this criteria are reverted.
- **Reserves:** service providers can never withdraw more LINK than they are owed. It should not be possible to withdraw more LINK from the contract than the sum of the service provider linkAmountOwed, with the exception of the emergencyWithdraw functionality.
- **Reserves:** the total amount owed must equal to the sum of all positive earmark owedLinkAmounts

## Attack ideas (where to focus for bugs)

- Draining of funds
- Indefinite fund locking within contracts with no way to emergency withdraw
- Unauthorized withdrawals
- Invariant breaks (e.g. withdrawing more funds than is owed in the Reserves contract, or withdrawing when non-allowlisted)
- Exploits that can happen between contract interactions (e.g. re-entrancy attacks)
- Realistic system DoS attacks with limited capital (e.g. by depositing tokens, or initiating permissionless withdraws)
- Malicious MEV / pool manipulation that would bypass slippage controls & parameters

## All trusted roles in the protocol

- UNPAUSER_ROLE, ASSET_MANAGER_ROLE, DEFAULT_ADMIN_ROLE, WITHDRAWER_ROLE, EARMARK_MANAGER_ROLE, SWAPPER_ROLE
- BRIDGER_ROLE, PAUSER_ROLE, forwarder (s_forwarder). If the role goes malicious, the contracts should not break in a critical way (with the exception of temporary DoS / pausing)

✅ SCOUTS: Please format the response above 👆 using the template below👇

| Role                                | Description                       |
| --------------------------------------- | ---------------------------- |
| Owner                          | Has superpowers                |
| Administrator                             | Can change fees                       |

## Describe any novel or unique curve logic or mathematical models implemented in the contracts:

The contracts do not present any unique or novel mathematical models. However, the slippage calculation methodology is worthwhile to understand, and is explained below.
For each asset:

1. Determine the balance within the contract assetBalance
1. Convert the balance to the USD value using Data Feed value assetPrice : `availableAssetUsdValue = assetBalance * assetPriceUsd`
1. Retrieve the decimals of the asset assetDecimals , and compute the asset unit: `assetUnit = 10 ** assetDecimals`
1. Retrieve the minSwapSizeUsd parameter for the asset. If `availableAssetUsdValue < minSwapSize * assetUnit`, skip the asset for swapping
1. Cap the token value for swapping to the upper bound maxSwapSizeUsd parameter: `swapAmountIn = min(maxSwapSizeUsd * assetUnit, availableAssetUsdValue) / assetPrice`
1. Using the USD price of LINK linkUSDPrice, convert the input asset value amount to the equivalent amount out in LINK (note: LINK_DECIMALS = 18):
   a. When token has < decimals than LINK: `amountOutCLPriceFeedQuote = (swapAmountIn * assetPrice * 10 ** (LINK_DECIMALS - assetDecimals)) / linkUSDPrice`;
   b. When token has >= decimals than LINK: `(assetAmount * assetPrice) / linkUSDPrice / 10 ** (assetDecimals - LINK_DECIMALS)`;
1. Using the preconfigured Uniswap swap path path and the swapAmountIn, perform a Uniswap V3 trade simulation using quoteExactInput, and retrieve the output amountOutUniswapQuote
1. Using the maxSlippage parameter configured for the asset, if `amountOutUniswapQuote < amountOutCLPriceFeedQuote * (1 - maxSlippage)`, skip the swap
1. Set `amountOutMinimum = max(amountOutCLPriceFeedQuote, amountOutUniswapQuote) * (1 - maxSlippage)`. This will be the input to exactInput on the actual swap execution
1. After the swap with actualAmountOut, and using the maxDeviation parameter
   a. amountInConvertedToLINKUsdValue - following same steps as 6) with the amountIn input for exactInput
   b. Revert the trade if the following condition is not met: `actualAmountOut >= amountInConvertedToLINKUsdValue * (1 - maxDeviation)`

## Running tests





Prerequisites:
1. Setup pnpm: https://pnpm.io/installation
2. Setup foundry: https://book.getfoundry.sh/getting-started/installation
3. For coverage install `lcov` (see https://stackoverflow.com/a/77967141)

```bash
git clone https://github.com/code-423n4/2024-12-chainlink.git
cd 2024-12-chainlink

cp .env.example .env
# then set MAINNET_RPC_URL to a valid rpc url

pnpm foundry
pnpm install
forge build
pnpm test

# To get coverage run
pnpm test:coverage
```

## Coverage

| File                                 | % Lines           | % Statements      | % Branches      | % Funcs         |
|--------------------------------------|-------------------|-------------------|-----------------|-----------------|
| src/EmergencyWithdrawer.sol          | 100.00% (13/13)   | 100.00% (15/15)   | 100.00% (4/4)   | 100.00% (4/4)   |
| src/FeeAggregator.sol                | 100.00% (110/110) | 99.38% (160/161)  | 100.00% (19/19) | 100.00% (18/18) |
| src/FeeRouter.sol                    | 100.00% (28/28)   | 100.00% (33/33)   | 100.00% (6/6)   | 100.00% (6/6)   |
| src/PausableWithAccessControl.sol    | 100.00% (14/14)   | 100.00% (20/20)   | 100.00% (2/2)   | 100.00% (9/9)   |
| src/Reserves.sol                     | 100.00% (49/49)   | 100.00% (66/66)   | 100.00% (11/11) | 100.00% (11/11) |
| src/SwapAutomator.sol                | 100.00% (163/163) | 100.00% (216/216) | 100.00% (35/35) | 100.00% (26/26) |
| src/libraries/EnumerableBytesSet.sol | 100.00% (30/30)   | 100.00% (39/39)   | 100.00% (5/5)   | 100.00% (12/12) |
| Total                                | 100.00% (407/407) | 99.82% (549/550)  | 100.00% (82/82) | 100.00% (86/86) |

## Miscellaneous
Employees of Chainlink and employees' family members are ineligible to participate in this audit.

Code4rena's rules cannot be overridden by the contents of this README. In case of doubt, please check with C4 staff.
