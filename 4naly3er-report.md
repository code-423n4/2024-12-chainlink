# Report


## Gas Optimizations


| |Issue|Instances|
|-|:-|:-:|
| [GAS-1](#GAS-1) | `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings) | 2 |
| [GAS-2](#GAS-2) | Cache array length outside of loop | 27 |
| [GAS-3](#GAS-3) | For Operations that will not overflow, you could use unchecked | 147 |
| [GAS-4](#GAS-4) | Avoid contract existence checks by using low level calls | 5 |
| [GAS-5](#GAS-5) | Functions guaranteed to revert when called by normal users can be marked `payable` | 8 |
| [GAS-6](#GAS-6) | `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`) | 1 |
| [GAS-7](#GAS-7) | Using `private` rather than `public` for constants, saves gas | 11 |
| [GAS-8](#GAS-8) | Use of `this` instead of marking as `public` an `external` function | 1 |
| [GAS-9](#GAS-9) | Increments/decrements can be unchecked in for-loops | 27 |
| [GAS-10](#GAS-10) | Use != 0 instead of > 0 for unsigned integer comparison | 2 |
### <a name="GAS-1"></a>[GAS-1] `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings)
This saves **16 gas per instance.**

*Instances (2)*:
```solidity
File: ./src/Reserves.sol

126:             totalAmountOwed += amountLinkOwed;

132:             serviceProviderInfo.linkBalance += amountLinkOwed;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

### <a name="GAS-2"></a>[GAS-2] Cache array length outside of loop
If not cached, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).

*Instances (27)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

38:         for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

152:         for (uint256 i; i < message.destTokenAmounts.length; ++i) {

170:         for (uint256 i; i < assets.length; ++i) {

181:         for (uint256 i; i < assets.length; ++i) {

276:         for (uint256 i; i < bridgeAssetAmounts.length; ++i) {

326:         for (uint256 i; i < assetsToRemove.length; ++i) {

335:         for (uint256 i; i < assetsToAdd.length; ++i) {

363:         for (uint256 i; i < assets.length; ++i) {

386:         for (uint256 i; i < sendersToRemove.length; ++i) {

390:             for (uint256 j; j < senders.length; ++j) {

405:         for (uint256 i; i < sendersToAdd.length; ++i) {

409:             for (uint256 j; j < senders.length; ++j) {

433:         for (uint256 i; i < receiversToRemove.length; ++i) {

437:             for (uint256 j; j < receivers.length; ++j) {

453:         for (uint256 i; i < receiversToAdd.length; ++i) {

457:             for (uint256 j; j < receivers.length; ++j) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

76:         for (uint256 i = 0; i < assets.length; ++i) {

101:         for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

120:         for (uint256 i; i < earmarks.length; ++i) {

168:         for (uint256 i; i < serviceProviders.length; ++i) {

202:         for (uint256 i; i < serviceProviders.length; ++i) {

220:         for (uint256 i; i < serviceProviders.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

200:         for (uint256 i; i < assetsToRemove.length; ++i) {

220:         for (uint256 i; i < assetSwapParamsArgs.assetsSwapParams.length; ++i) {

398:         for (uint256 i; i < allowlistedAssets.length; ++i) {

499:         for (uint256 i; i < swapInputs.length; ++i) {

510:         for (uint256 i; i < swapInputs.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-3"></a>[GAS-3] For Operations that will not overflow, you could use unchecked

*Instances (147)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

4: import {PausableWithAccessControl} from "src/PausableWithAccessControl.sol";

5: import {Errors} from "src/libraries/Errors.sol";

7: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

8: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

38:         for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

4: import {IAccessControl} from "@openzeppelin/contracts/access/IAccessControl.sol";

5: import {IAccessControlDefaultAdminRules} from "@openzeppelin/contracts/access/extensions/IAccessControlDefaultAdminRules.sol";

6: import {IAccessControlEnumerable} from "@openzeppelin/contracts/access/extensions/IAccessControlEnumerable.sol";

7: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

8: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

9: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

11: import {EmergencyWithdrawer} from "src/EmergencyWithdrawer.sol";

12: import {PausableWithAccessControl} from "src/PausableWithAccessControl.sol";

13: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

14: import {EnumerableBytesSet} from "src/libraries/EnumerableBytesSet.sol";

15: import {Errors} from "src/libraries/Errors.sol";

16: import {Roles} from "src/libraries/Roles.sol";

18: import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";

19: import {IAny2EVMMessageReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IAny2EVMMessageReceiver.sol";

20: import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";

21: import {ILinkAvailable} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol";

22: import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";

23: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

24: import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol";

25: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

87:         address admin; // ───────────────────────────╮ The initial contract admin

88:         uint48 adminRoleTransferDelay; // ───────────╯ The min seconds before the admin address can be transferred

89:         address linkToken; //    The LINK token

90:         address ccipRouterClient; //    The CCIP Router client

95:         uint64 sourceChainSelector; // ─╮ The source chain selector to allowlist the senders for

96:         bytes[] senders; // ────────────╯ The list of encoded sender addresses to be added to the allowlist

101:         uint64 destChainSelector; // ─╮ The destination chain selector to allowlist the senders for

102:         bytes[] receivers; // ────────╯ The list of encoded receiver addresses to be added to the allowlist

152:         for (uint256 i; i < message.destTokenAmounts.length; ++i) {

170:         for (uint256 i; i < assets.length; ++i) {

181:         for (uint256 i; i < assets.length; ++i) {

276:         for (uint256 i; i < bridgeAssetAmounts.length; ++i) {

326:         for (uint256 i; i < assetsToRemove.length; ++i) {

335:         for (uint256 i; i < assetsToAdd.length; ++i) {

363:         for (uint256 i; i < assets.length; ++i) {

386:         for (uint256 i; i < sendersToRemove.length; ++i) {

390:             for (uint256 j; j < senders.length; ++j) {

405:         for (uint256 i; i < sendersToAdd.length; ++i) {

409:             for (uint256 j; j < senders.length; ++j) {

433:         for (uint256 i; i < receiversToRemove.length; ++i) {

437:             for (uint256 j; j < receivers.length; ++j) {

453:         for (uint256 i; i < receiversToAdd.length; ++i) {

457:             for (uint256 j; j < receivers.length; ++j) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

6: import {EmergencyWithdrawer} from "src/EmergencyWithdrawer.sol";

7: import {Errors} from "src/libraries/Errors.sol";

8: import {Roles} from "src/libraries/Roles.sol";

10: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

11: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

12: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

13: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

76:         for (uint256 i = 0; i < assets.length; ++i) {

101:         for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

4: import {IPausable} from "src/interfaces/IPausable.sol";

6: import {Roles} from "src/libraries/Roles.sol";

8: import {AccessControlDefaultAdminRules} from "@openzeppelin/contracts/access/extensions/AccessControlDefaultAdminRules.sol";

9: import {IAccessControlEnumerable} from "@openzeppelin/contracts/access/extensions/IAccessControlEnumerable.sol";

10: import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

11: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

4: import {EmergencyWithdrawer} from "src/EmergencyWithdrawer.sol";

5: import {Errors} from "src/libraries/Errors.sol";

6: import {Roles} from "src/libraries/Roles.sol";

8: import {ILinkAvailable} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol";

9: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

10: import {IERC677Receiver} from "@chainlink/contracts/src/v0.8/shared/token/ERC677/IERC677Receiver.sol";

11: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

12: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

13: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

56:         uint48 adminRoleTransferDelay; // ─╮ The minimum amount of seconds that must pass before

58:         address admin; // ─────────────────╯ The address of the admin

59:         address linkToken; //                The address of the LINK token

66:         address serviceProvider; // ─╮ The address of the service provider

67:         int96 amountLinkOwed; // ────╯ The amount of LINK in juels owed to the service provider. This value can be

69:         bytes data; //                 Arbitrary data associated with the earmark

76:         int96 linkBalance; // ─────╮ LINK balance in juels owed to the service provider. This value

78:         uint96 earmarkCounter; // ─╯ Running counter used to track unique earmark IDs. The value represents the

120:         for (uint256 i; i < earmarks.length; ++i) {

126:             totalAmountOwed += amountLinkOwed;

131:             uint256 earmarkCounter = ++serviceProviderInfo.earmarkCounter;

132:             serviceProviderInfo.linkBalance += amountLinkOwed;

168:         for (uint256 i; i < serviceProviders.length; ++i) {

180:             totalAmountOwed -= linkBalance;

202:         for (uint256 i; i < serviceProviders.length; ++i) {

220:         for (uint256 i; i < serviceProviders.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

6: import {FeeAggregator} from "src/FeeAggregator.sol";

7: import {PausableWithAccessControl} from "src/PausableWithAccessControl.sol";

8: import {Errors} from "src/libraries/Errors.sol";

9: import {Roles} from "src/libraries/Roles.sol";

11: import {PercentageMath} from "@aave/core-v3/contracts/protocol/libraries/math/PercentageMath.sol";

12: import {AutomationCompatible} from "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

13: import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol";

14: import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

15: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

16: import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol";

17: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

18: import {IERC20Metadata} from "@openzeppelin/contracts/interfaces/IERC20Metadata.sol";

19: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

20: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

21: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

22: import {IV3SwapRouter} from "@uniswap/swap-router-contracts/contracts/interfaces/IV3SwapRouter.sol";

23: import {IQuoterV2} from "@uniswap/v3-periphery/contracts/interfaces/IQuoterV2.sol";

77:         uint48 adminRoleTransferDelay; // ─╮ The minimum amount of seconds that must pass before the admin address can be

79:         address admin; // ─────────────────╯ The initial contract admin

80:         uint96 deadlineDelay; // ──────────╮ The maximum amount of seconds the swap transaction is valid for

81:         address linkToken; // ─────────────╯ The Link token

82:         address feeAggregator; //            The Fee Aggregator

83:         address linkUsdFeed; //              The link usd feed

84:         address uniswapRouter; //            The address of the Uniswap router

85:         address uniswapQuoterV2; //          The address of the Uniswap QuoterV2

86:         address linkReceiver; //             The address that will receive converted LINK

92:         AggregatorV3Interface oracle; // ─╮ The asset usd oracle

93:         uint16 maxSlippage; //            │ The maximum allowed slippage for the swap in basis points

94:         uint16 maxPriceDeviation; //      │  The maximum allowed one-side deviation of actual swapped out amount

96:         uint64 swapInterval; // ──────────╯ The minimum interval between swaps

97:         uint128 minSwapSizeUsd; // ───────╮ The minimum swap size expressed in USD 8 decimals

98:         uint128 maxSwapSizeUsd; // ───────╯ The maximum swap size expressed in USD 8 decimals

99:         bytes path; //                      The swap path

104:         address[] assets; // The list of assets

105:         SwapParams[] assetsSwapParams; // The list of swap parameters

200:         for (uint256 i; i < assetsToRemove.length; ++i) {

220:         for (uint256 i; i < assetSwapParamsArgs.assetsSwapParams.length; ++i) {

398:         for (uint256 i; i < allowlistedAssets.length; ++i) {

409:             if (assetPrice == 0 || updatedAt < block.timestamp - STALENESS_THRESHOLD) continue;

410:             uint256 assetUnit = 10 ** IERC20Metadata(asset).decimals();

413:             uint256 availableAssetUsdValue = IERC20(asset).balanceOf(address(s_feeAggregator)) * assetPrice;

418:                 availableAssetUsdValue >= swapParams.minSwapSizeUsd * assetUnit &&

419:                 block.timestamp - s_latestSwapTimestamp[asset] >= swapParams.swapInterval

422:                 uint256 swapAmountIn = Math.min(swapParams.maxSwapSizeUsd * assetUnit, availableAssetUsdValue) /

442:                         amountOutCLPriceFeedQuote.percentMul(PercentageMath.PERCENTAGE_FACTOR - swapParams.maxSlippage)

448:                 swapInputs[idx++] = IV3SwapRouter.ExactInputParams({

455:                         PercentageMath.PERCENTAGE_FACTOR - swapParams.maxSlippage

470:             return (true, abi.encode(swapInputs, block.timestamp + s_deadlineDelay));

499:         for (uint256 i; i < swapInputs.length; ++i) {

510:         for (uint256 i; i < swapInputs.length; ++i) {

588:             linkAmountOutFromPriceFeed.percentMul(PercentageMath.PERCENTAGE_FACTOR - swapParams.maxPriceDeviation)

608:         if (updatedAt < block.timestamp - STALENESS_THRESHOLD) {

630:             return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

632:             return (assetAmount * assetPrice) / linkUSDPrice / 10 ** (tokenDecimals - LINK_DECIMALS);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

```solidity
File: ./src/libraries/EnumerableBytesSet.sol

50:             uint256 valueIndex = position - 1;

51:             uint256 lastIndex = set._values.length - 1;

125:         assembly ("memory-safe") {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/EnumerableBytesSet.sol)

### <a name="GAS-4"></a>[GAS-4] Avoid contract existence checks by using low level calls
Prior to 0.8.10 the compiler inserted extra code, including `EXTCODESIZE` (**100 gas**), to check for contract existence for external function calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value. Similar behavior can be achieved in earlier versions by using low-level calls, since low level calls never check for contract existence

*Instances (5)*:
```solidity
File: ./src/FeeAggregator.sol

252:         uint256 currentBalance = i_linkToken.balanceOf(address(this));

307:         return int256(i_linkToken.balanceOf(address(this)));

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/Reserves.sol

139:         uint256 currentReserves = i_linkToken.balanceOf(address(this));

263:         return int256(i_linkToken.balanceOf(address(this)));

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

413:             uint256 availableAssetUsdValue = IERC20(asset).balanceOf(address(s_feeAggregator)) * assetPrice;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-5"></a>[GAS-5] Functions guaranteed to revert when called by normal users can be marked `payable`
If a function modifier such as `onlyOwner` is used, the function will revert if a normal user tries to pay the function. Marking the function as `payable` will lower the gas cost for legitimate callers because the compiler will not include checks for whether a payment was provided.

*Instances (8)*:
```solidity
File: ./src/FeeRouter.sol

115:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

32:     function emergencyPause() external onlyRole(Roles.PAUSER_ROLE) {

43:     function emergencyUnpause() external onlyRole(Roles.UNPAUSER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

114:     function setEarmarks(Earmark[] calldata earmarks) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

175:     function setForwarder(address forwarder) external onlyRole(DEFAULT_ADMIN_ROLE) {

256:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

277:     function setDeadlineDelay(uint96 deadlineDelay) external onlyRole(Roles.ASSET_ADMIN_ROLE) {

364:     function setLinkReceiver(address linkReceiver) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-6"></a>[GAS-6] `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`)
Pre-increments and pre-decrements are cheaper.

For a `uint256 i` variable, the following is true with the Optimizer enabled at 10k:

**Increment:**

- `i += 1` is the most expensive form
- `i++` costs 6 gas less than `i += 1`
- `++i` costs 5 gas less than `i++` (11 gas less than `i += 1`)

**Decrement:**

- `i -= 1` is the most expensive form
- `i--` costs 11 gas less than `i -= 1`
- `--i` costs 5 gas less than `i--` (16 gas less than `i -= 1`)

Note that post-increments (or post-decrements) return the old value before incrementing or decrementing, hence the name *post-increment*:

```solidity
uint i = 1;  
uint j = 2;
require(j == i++, "This will be false as i is incremented after the comparison");
```
  
However, pre-increments (or pre-decrements) return the new value:
  
```solidity
uint i = 1;  
uint j = 2;
require(j == ++i, "This will be true as i is incremented before the comparison");
```

In the pre-increment case, the compiler has to create a temporary variable (when used) for returning `1` instead of `2`.

Consider using pre-increments and pre-decrements where they are relevant (meaning: not where post-increments/decrements logic are relevant).

*Saves 5 gas per instance*

*Instances (1)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

38:         for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

### <a name="GAS-7"></a>[GAS-7] Using `private` rather than `public` for constants, saves gas
If needed, the values can be read from the verified contract source code, or if there are multiple values there can be a single getter function that [returns a tuple](https://github.com/code-423n4/2022-08-frax/blob/90f55a9ce4e25bceed3a74290b854341d8de6afa/src/contracts/FraxlendPair.sol#L156-L178) of the values of all currently-public constants. Saves **3406-3606 gas** in deployment gas due to the compiler not having to create non-payable getter functions for deployment calldata, not having to store the bytes of the value outside of where it's used, and not adding another entry to the method ID table

*Instances (11)*:
```solidity
File: ./src/FeeAggregator.sol

106:     string public constant override typeAndVersion = "Fee Aggregator 1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

38:     string public constant override typeAndVersion = "FeeRouter v1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

83:     string public constant override typeAndVersion = "Reserves 1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

109:     string public constant override typeAndVersion = "Uniswap V3 Swap Automator 1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

```solidity
File: ./src/libraries/Roles.sol

8:     bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

12:     bytes32 public constant UNPAUSER_ROLE = keccak256("UNPAUSER_ROLE");

17:     bytes32 public constant ASSET_ADMIN_ROLE = keccak256("ASSET_ADMIN_ROLE");

21:     bytes32 public constant BRIDGER_ROLE = keccak256("BRIDGER_ROLE");

25:     bytes32 public constant EARMARK_MANAGER_ROLE = keccak256("EARMARK_MANAGER_ROLE");

29:     bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

33:     bytes32 public constant SWAPPER_ROLE = keccak256("SWAPPER_ROLE");

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Roles.sol)

### <a name="GAS-8"></a>[GAS-8] Use of `this` instead of marking as `public` an `external` function
Using `this.` is like making an expensive external call. Consider marking the called function as public

*Saves around 2000 gas per instance*

*Instances (1)*:
```solidity
File: ./src/SwapAutomator.sol

538:                 try this.swapWithPriceFeedValidation(swapInputs[i], asset, linkPriceFromFeed) returns (

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-9"></a>[GAS-9] Increments/decrements can be unchecked in for-loops
In Solidity 0.8+, there's a default overflow check on unsigned integers. It's possible to uncheck this in for-loops and save some gas at each iteration, but at the cost of some code readability, as this uncheck cannot be made inline.

[ethereum/solidity#10695](https://github.com/ethereum/solidity/issues/10695)

The change would be:

```diff
- for (uint256 i; i < numIterations; i++) {
+ for (uint256 i; i < numIterations;) {
 // ...  
+   unchecked { ++i; }
}  
```

These save around **25 gas saved** per instance.

The same can be applied with decrements (which should use `break` when `i == 0`).

The risk of overflow is non-existent for `uint256`.

*Instances (27)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

38:         for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

152:         for (uint256 i; i < message.destTokenAmounts.length; ++i) {

170:         for (uint256 i; i < assets.length; ++i) {

181:         for (uint256 i; i < assets.length; ++i) {

276:         for (uint256 i; i < bridgeAssetAmounts.length; ++i) {

326:         for (uint256 i; i < assetsToRemove.length; ++i) {

335:         for (uint256 i; i < assetsToAdd.length; ++i) {

363:         for (uint256 i; i < assets.length; ++i) {

386:         for (uint256 i; i < sendersToRemove.length; ++i) {

390:             for (uint256 j; j < senders.length; ++j) {

405:         for (uint256 i; i < sendersToAdd.length; ++i) {

409:             for (uint256 j; j < senders.length; ++j) {

433:         for (uint256 i; i < receiversToRemove.length; ++i) {

437:             for (uint256 j; j < receivers.length; ++j) {

453:         for (uint256 i; i < receiversToAdd.length; ++i) {

457:             for (uint256 j; j < receivers.length; ++j) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

76:         for (uint256 i = 0; i < assets.length; ++i) {

101:         for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

120:         for (uint256 i; i < earmarks.length; ++i) {

168:         for (uint256 i; i < serviceProviders.length; ++i) {

202:         for (uint256 i; i < serviceProviders.length; ++i) {

220:         for (uint256 i; i < serviceProviders.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

200:         for (uint256 i; i < assetsToRemove.length; ++i) {

220:         for (uint256 i; i < assetSwapParamsArgs.assetsSwapParams.length; ++i) {

398:         for (uint256 i; i < allowlistedAssets.length; ++i) {

499:         for (uint256 i; i < swapInputs.length; ++i) {

510:         for (uint256 i; i < swapInputs.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-10"></a>[GAS-10] Use != 0 instead of > 0 for unsigned integer comparison

*Instances (2)*:
```solidity
File: ./src/Reserves.sol

140:         if (totalAmountOwed > 0 && uint256(int256(totalAmountOwed)) > currentReserves) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

469:         if (idx > 0) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)


## Non Critical Issues


| |Issue|Instances|
|-|:-|:-:|
| [NC-1](#NC-1) | `constant`s should be defined rather than using magic numbers | 3 |
| [NC-2](#NC-2) | Control structures do not follow the Solidity Style Guide | 20 |
| [NC-3](#NC-3) | Critical Changes Should Use Two-step Procedure | 4 |
| [NC-4](#NC-4) | Unused `error` definition | 30 |
| [NC-5](#NC-5) | Functions should not be longer than 50 lines | 67 |
| [NC-6](#NC-6) | Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor | 3 |
| [NC-7](#NC-7) | Consider using named mappings | 1 |
| [NC-8](#NC-8) | Take advantage of Custom Error's return value property | 35 |
| [NC-9](#NC-9) | Variables need not be initialized to zero | 3 |
### <a name="NC-1"></a>[NC-1] `constant`s should be defined rather than using magic numbers
Even [assembly](https://github.com/code-423n4/2022-05-opensea-seaport/blob/9d7ce4d08bf3c3010304a0476a785c70c0e90ae7/contracts/lib/TokenTransferrer.sol#L35-L39) can benefit from using readable constants instead of hex/numeric literals

*Instances (3)*:
```solidity
File: ./src/SwapAutomator.sol

410:             uint256 assetUnit = 10 ** IERC20Metadata(asset).decimals();

630:             return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

632:             return (assetAmount * assetPrice) / linkUSDPrice / 10 ** (tokenDecimals - LINK_DECIMALS);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-2"></a>[NC-2] Control structures do not follow the Solidity Style Guide
See the [control structures](https://docs.soliditylang.org/en/latest/style-guide.html#control-structures) section of the Solidity Style Guide

*Instances (20)*:
```solidity
File: ./src/FeeAggregator.sol

13: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

483:             interfaceId == type(IFeeAggregator).interfaceId ||

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

41:     IFeeAggregator private s_feeAggregator;

47:         s_feeAggregator = IFeeAggregator(params.feeAggregator);

68:         IFeeAggregator feeAggregator = s_feeAggregator;

93:         IFeeAggregator feeAggregator = s_feeAggregator;

130:         s_feeAggregator = IFeeAggregator(newFeeAggregator);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

249:         if (msg.sender != address(i_linkToken)) revert Errors.SenderNotLinkToken();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

134:     IFeeAggregator private s_feeAggregator;

148:         if (

224:             if (

263:         if (feeAggregator == address(0)) revert Errors.InvalidZeroAddress();

409:             if (assetPrice == 0 || updatedAt < block.timestamp - STALENESS_THRESHOLD) continue;

417:             if (

440:                     if (

504:         IFeeAggregator feeAggregator = s_feeAggregator;

586:         if (

607:         if (answer == 0) revert Errors.ZeroOracleData();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-3"></a>[NC-3] Critical Changes Should Use Two-step Procedure
The critical procedures should be two step process.

See similar findings in previous Code4rena contests for reference: <https://code4rena.com/reports/2022-06-illuminate/#2-critical-changes-should-use-two-step-procedure>

**Recommended Mitigation Steps**

Lack of two-step procedure for critical operations leaves them error-prone. Consider adding two step procedure on the critical functions.

*Instances (4)*:
```solidity
File: ./src/FeeRouter.sol

115:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/SwapAutomator.sol

175:     function setForwarder(address forwarder) external onlyRole(DEFAULT_ADMIN_ROLE) {

256:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

364:     function setLinkReceiver(address linkReceiver) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-4"></a>[NC-4] Unused `error` definition
Note that there may be cases where an error superficially appears to be used, but this is only because there are multiple definitions of the error in different files. In such cases, the error definition should be moved into a separate file. The instances below are the unused definitions.

*Instances (30)*:
```solidity
File: ./src/libraries/Errors.sol

7:     error InvalidZeroAddress();

9:     error EmptyList();

13:     error AssetAlreadyAllowlisted(address asset);

17:     error AssetNotAllowlisted(address asset);

20:     error AssetsSwapParamsMismatch();

25:     error InsufficientBalance(uint256 currentBalance, uint256 fee);

30:     error SenderAlreadyAllowlisted(uint64 chainSelector, bytes sender);

35:     error SenderNotAllowlisted(uint64 chainSelector, bytes sender);

37:     error EmptySwapPath();

40:     error FeeAggregatorNotUpdated();

42:     error ForwarderNotUpdated();

44:     error InvalidSlippage();

47:     error InvalidSwapPath();

50:     error FeeRecipientMismatch();

52:     error ZeroOracleData();

55:     error StaleOracleData();

57:     error LINKReceiverNotUpdated();

60:     error AccessForbidden();

63:     error InsufficientAmountReceived();

65:     error InvalidZeroAmount();

67:     error AllSwapsFailed();

69:     error DeadlineDelayNotUpdated();

72:     error DeadlineDelayTooLow(uint96 deadlineDelay, uint96 minDeadlineDelay);

75:     error DeadlineDelayTooHigh(uint96 deadlineDelay, uint96 maxDeadlineDelay);

77:     error TransactionTooOld(uint256 timestamp, uint256 deadline);

79:     error AssetAllowlisted(address asset);

81:     error SenderNotLinkToken();

86:     error ReceiverNotAllowlisted(uint64 chainSelector, bytes receiver);

91:     error ReceiverAlreadyAllowlisted(uint64 chainSelector, bytes receiver);

93:     error ArrayLengthMismatch();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Errors.sol)

### <a name="NC-5"></a>[NC-5] Functions should not be longer than 50 lines
Overly complex code can make understanding functionality more difficult, try to further modularize your code to ensure readability 

*Instances (67)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

46:     function _validateAssetTransferInputs(address[] calldata assets, uint256[] calldata amounts) internal pure {

63:     function _transferAsset(address to, address asset, uint256 amount) internal {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

147:     function _ccipReceive(Client.Any2EVMMessage memory message) internal override {

180:     function areAssetsAllowlisted(address[] calldata assets) external view returns (bool, address) {

191:     function getAllowlistedAssets() external view returns (address[] memory) {

198:     function getAllowlistedSenders(uint64 chainSelector) external view returns (bytes[] memory) {

204:     function getAllowlistedSourceChains() external view returns (uint256[] memory) {

210:     function getAllowlistedDestinationChains() external view returns (uint256[] memory) {

298:     function getAllowlistedReceivers(uint64 destChainSelector) external view returns (bytes[] memory) {

303:     function linkAvailableForPayment() external view returns (int256 linkBalance) {

473:     function getLinkToken() external view returns (LinkTokenInterface) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

115:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

119:     function _setFeeAggregator(address newFeeAggregator) internal {

137:     function getFeeAggregator() external view returns (IFeeAggregator) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

32:     function emergencyPause() external onlyRole(Roles.PAUSER_ROLE) {

37:     function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {

43:     function emergencyUnpause() external onlyRole(Roles.UNPAUSER_ROLE) {

48:     function getRoleMember(bytes32 role, uint256 index) external view override returns (address) {

53:     function getRoleMemberCount(bytes32 role) external view override returns (uint256) {

60:     function getRoleMembers(bytes32 role) public view virtual returns (address[] memory) {

65:     function _grantRole(bytes32 role, address account) internal virtual override returns (bool) {

74:     function _revokeRole(bytes32 role, address account) internal virtual override returns (bool) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

114:     function setEarmarks(Earmark[] calldata earmarks) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

149:     function getTotalLinkAmountOwed() external view returns (int96) {

162:     function withdraw(address[] calldata serviceProviders) external whenNotPaused {

230:     function isServiceProviderAllowlisted(address serviceProvider) external view returns (bool) {

237:     function getServiceProvider(address serviceProvider) external view returns (ServiceProvider memory) {

248:     function onTokenTransfer(address, uint256, bytes calldata) external view {

254:     function getLinkToken() external view returns (IERC20) {

259:     function linkAvailableForPayment() external view returns (int256 linkBalance) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

175:     function setForwarder(address forwarder) external onlyRole(DEFAULT_ADMIN_ROLE) {

246:     function getAssetSwapParams(address asset) external view returns (SwapParams memory) {

256:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

262:     function _setFeeAggregator(address feeAggregator) internal {

277:     function setDeadlineDelay(uint96 deadlineDelay) external onlyRole(Roles.ASSET_ADMIN_ROLE) {

283:     function _setDeadlineDelay(uint96 deadlineDelay) internal {

300:     function getLINKUsdFeed() external view returns (AggregatorV3Interface) {

306:     function getForwarder() external view returns (address) {

312:     function getLINK() external view returns (LinkTokenInterface) {

318:     function getUniswapRouter() external view returns (IV3SwapRouter) {

324:     function getUniswapQuoterV2() external view returns (IQuoterV2) {

330:     function getFeeAggregator() external view returns (IFeeAggregator) {

336:     function getLatestSwapTimestamp(address asset) external view returns (uint256) {

342:     function getDeadlineDelay() external view returns (uint96) {

348:     function getHashedSwapPath(address asset) external view returns (bytes32) {

354:     function getLinkReceiver() external view returns (address) {

364:     function setLinkReceiver(address linkReceiver) external onlyRole(DEFAULT_ADMIN_ROLE) {

371:     function _setLinkReceiver(address linkReceiver) internal {

389:     function checkUpkeep(bytes calldata) external whenNotPaused cannotExecute returns (bool, bytes memory) {

478:     function performUpkeep(bytes calldata performData) external whenNotPaused {

598:     function _getAssetPrice(AggregatorV3Interface oracle) private view returns (uint256, uint256) {

604:     function _getValidatedLINKFeedPrice() private view returns (uint256) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

```solidity
File: ./src/interfaces/IFeeAggregator.sol

10:     function transferForSwap(address to, address[] calldata assets, uint256[] calldata amounts) external;

14:     function getAllowlistedAssets() external view returns (address[] memory);

20:     function areAssetsAllowlisted(address[] calldata assets) external view returns (bool, address);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/interfaces/IFeeAggregator.sol)

```solidity
File: ./src/libraries/EnumerableBytesSet.sol

16:     function add(BytesSet storage set, bytes memory value) internal returns (bool) {

20:     function _add(BytesSet storage set, bytes memory value) private returns (bool) {

36:     function remove(BytesSet storage set, bytes memory value) internal returns (bool) {

40:     function _remove(BytesSet storage set, bytes memory value) private returns (bool) {

78:     function contains(BytesSet storage set, bytes memory value) internal view returns (bool) {

82:     function _contains(BytesSet storage set, bytes memory value) private view returns (bool) {

89:     function length(BytesSet storage set) internal view returns (uint256) {

93:     function _length(BytesSet storage set) private view returns (uint256) {

104:     function at(BytesSet storage set, uint256 index) internal view returns (bytes memory) {

108:     function _at(BytesSet storage set, uint256 index) private view returns (bytes memory) {

121:     function values(BytesSet storage set) internal view returns (bytes[] memory) {

132:     function _values(BytesSet storage set) private view returns (bytes[] memory) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/EnumerableBytesSet.sol)

### <a name="NC-6"></a>[NC-6] Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor
If a function is supposed to be access-controlled, a `modifier` should be used instead of a `require/if` statement for more readability.

*Instances (3)*:
```solidity
File: ./src/Reserves.sol

249:         if (msg.sender != address(i_linkToken)) revert Errors.SenderNotLinkToken();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

479:         if (msg.sender != s_forwarder) {

572:         if (msg.sender != address(this)) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-7"></a>[NC-7] Consider using named mappings
Consider moving to solidity version 0.8.18 or later, and using [named mappings](https://ethereum.stackexchange.com/questions/51629/how-to-name-the-arguments-in-mapping/145555#145555) to make it easier to understand the purpose of each mapping

*Instances (1)*:
```solidity
File: ./src/FeeAggregator.sol

126:     mapping(uint64 => EnumerableBytesSet.BytesSet) private s_allowlistedReceivers;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

### <a name="NC-8"></a>[NC-8] Take advantage of Custom Error's return value property
An important feature of Custom Error is that values such as address, tokenID, msg.value can be written inside the () sign, this kind of approach provides a serious advantage in debugging and examining the revert details of dapps such as tenderly.

*Instances (35)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

48:             revert Errors.EmptyList();

51:             revert Errors.ArrayLengthMismatch();

65:             revert Errors.InvalidZeroAddress();

68:             revert Errors.InvalidZeroAmount();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

132:             revert Errors.InvalidZeroAddress();

338:                 revert Errors.InvalidZeroAddress();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

45:             revert Errors.InvalidZeroAddress();

121:             revert Errors.InvalidZeroAddress();

124:             revert Errors.FeeAggregatorNotUpdated();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

98:             revert Errors.InvalidZeroAddress();

116:             revert Errors.EmptyList();

164:             revert Errors.EmptyList();

199:             revert Errors.EmptyList();

217:             revert Errors.EmptyList();

249:         if (msg.sender != address(i_linkToken)) revert Errors.SenderNotLinkToken();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

154:             revert Errors.InvalidZeroAddress();

177:             revert Errors.InvalidZeroAddress();

180:             revert Errors.ForwarderNotUpdated();

209:             revert Errors.AssetsSwapParamsMismatch();

222:                 revert Errors.InvalidZeroAddress();

228:                 revert Errors.InvalidSlippage();

231:                 revert Errors.EmptySwapPath();

263:         if (feeAggregator == address(0)) revert Errors.InvalidZeroAddress();

265:             revert Errors.FeeAggregatorNotUpdated();

285:             revert Errors.DeadlineDelayNotUpdated();

373:             revert Errors.InvalidZeroAddress();

376:             revert Errors.LINKReceiverNotUpdated();

480:             revert Errors.AccessForbidden();

515:                 revert Errors.InvalidSwapPath();

519:                 revert Errors.FeeRecipientMismatch();

557:             revert Errors.AllSwapsFailed();

573:             revert Errors.AccessForbidden();

590:             revert Errors.InsufficientAmountReceived();

607:         if (answer == 0) revert Errors.ZeroOracleData();

609:             revert Errors.StaleOracleData();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-9"></a>[NC-9] Variables need not be initialized to zero
The default value for variables is zero, so initializing them to zero is superfluous.

*Instances (3)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

38:         for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeRouter.sol

76:         for (uint256 i = 0; i < assets.length; ++i) {

101:         for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)


## Low Issues


| |Issue|Instances|
|-|:-|:-:|
| [L-1](#L-1) | `decimals()` is not a part of the ERC-20 standard | 2 |
| [L-2](#L-2) | Division by zero not prevented | 1 |
| [L-3](#L-3) | Signature use at deadlines should be allowed | 3 |
| [L-4](#L-4) | Loss of precision | 2 |
| [L-5](#L-5) | Solidity version 0.8.20+ may not work on other chains due to `PUSH0` | 2 |
| [L-6](#L-6) | File allows a version of solidity that is susceptible to an assembly optimizer bug | 2 |
### <a name="L-1"></a>[L-1] `decimals()` is not a part of the ERC-20 standard
The `decimals()` function is not a part of the [ERC-20 standard](https://eips.ethereum.org/EIPS/eip-20), and was added later as an [optional extension](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol). As such, some valid ERC20 tokens do not support this interface, so it is unsafe to blindly cast all tokens to this interface, and then call this function.

*Instances (2)*:
```solidity
File: ./src/SwapAutomator.sol

410:             uint256 assetUnit = 10 ** IERC20Metadata(asset).decimals();

627:         uint256 tokenDecimals = asset.decimals();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-2"></a>[L-2] Division by zero not prevented
The divisions below take an input parameter which does not have any zero-value checks, which may lead to the functions reverting when zero is passed.

*Instances (1)*:
```solidity
File: ./src/SwapAutomator.sol

630:             return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-3"></a>[L-3] Signature use at deadlines should be allowed
According to [EIP-2612](https://github.com/ethereum/EIPs/blob/71dc97318013bf2ac572ab63fab530ac9ef419ca/EIPS/eip-2612.md?plain=1#L58), signatures used on exactly the deadline timestamp are supposed to be allowed. While the signature may or may not be used for the exact EIP-2612 use case (transfer approvals), for consistency's sake, all deadlines should follow this semantic. If the timestamp is an expiration rather than a deadline, consider whether it makes more sense to include the expiration timestamp as a valid timestamp, as is done for deadlines.

*Instances (3)*:
```solidity
File: ./src/SwapAutomator.sol

409:             if (assetPrice == 0 || updatedAt < block.timestamp - STALENESS_THRESHOLD) continue;

488:         if (deadline < block.timestamp) {

608:         if (updatedAt < block.timestamp - STALENESS_THRESHOLD) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-4"></a>[L-4] Loss of precision
Division by large numbers may result in the result being zero, due to solidity not supporting fractions. Consider requiring a minimum amount for the numerator to ensure that it is always larger than the denominator

*Instances (2)*:
```solidity
File: ./src/SwapAutomator.sol

630:             return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

632:             return (assetAmount * assetPrice) / linkUSDPrice / 10 ** (tokenDecimals - LINK_DECIMALS);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-5"></a>[L-5] Solidity version 0.8.20+ may not work on other chains due to `PUSH0`
The compiler for Solidity 0.8.20 switches the default target EVM version to [Shanghai](https://blog.soliditylang.org/2023/05/10/solidity-0.8.20-release-announcement/#important-note), which includes the new `PUSH0` op code. This op code may not yet be implemented on all L2s, so deployment on these chains will fail. To work around this issue, use an earlier [EVM](https://docs.soliditylang.org/en/v0.8.20/using-the-compiler.html?ref=zaryabs.com#setting-the-evm-version-to-target) [version](https://book.getfoundry.sh/reference/config/solidity-compiler#evm_version). While the project itself may or may not compile with 0.8.20, other projects with which it integrates, or which extend this project may, and those projects will have problems deploying these contracts/libraries.

*Instances (2)*:
```solidity
File: ./src/libraries/Errors.sol

2: pragma solidity ^0.8.0;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Errors.sol)

```solidity
File: ./src/libraries/Roles.sol

2: pragma solidity ^0.8.0;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Roles.sol)

### <a name="L-6"></a>[L-6] File allows a version of solidity that is susceptible to an assembly optimizer bug
In solidity versions 0.8.13 and 0.8.14, there is an [optimizer bug](https://github.com/ethereum/solidity-blog/blob/499ab8abc19391be7b7b34f88953a067029a5b45/_posts/2022-06-15-inline-assembly-memory-side-effects-bug.md) where, if the use of a variable is in a separate `assembly` block from the block in which it was stored, the `mstore` operation is optimized out, leading to uninitialized memory. The code currently does not have such a pattern of execution, but it does use `mstore`s in `assembly` blocks, so it is a risk for future changes. The affected solidity versions should be avoided if at all possible.

*Instances (2)*:
```solidity
File: ./src/libraries/Errors.sol

2: pragma solidity ^0.8.0;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Errors.sol)

```solidity
File: ./src/libraries/Roles.sol

2: pragma solidity ^0.8.0;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Roles.sol)


## Medium Issues


| |Issue|Instances|
|-|:-|:-:|
| [M-1](#M-1) | Centralization Risk for trusted owners | 25 |
| [M-2](#M-2) | `increaseAllowance/decreaseAllowance` won't work on mainnet for USDT | 4 |
| [M-3](#M-3) | Direct `supportsInterface()` calls may cause caller to revert | 3 |
### <a name="M-1"></a>[M-1] Centralization Risk for trusted owners

#### Impact:
Contracts have owners with privileged rights to perform admin tasks and need to be trusted to not perform malicious updates or drain funds.

*Instances (25)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

11: abstract contract EmergencyWithdrawer is PausableWithAccessControl {

23:     ) PausableWithAccessControl(adminRoleTransferDelay, admin) {}

35:     ) external whenPaused onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

167:     ) external whenNotPaused onlyRole(Roles.SWAPPER_ROLE) {

237:     ) external whenNotPaused onlyRole(Roles.BRIDGER_ROLE) returns (bytes32) {

325:     ) external onlyRole(Roles.ASSET_ADMIN_ROLE) whenNotPaused {

360:     ) external onlyRole(Roles.WITHDRAWER_ROLE) {

385:     ) external onlyRole(DEFAULT_ADMIN_ROLE) whenNotPaused {

432:     ) external onlyRole(DEFAULT_ADMIN_ROLE) whenNotPaused {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

65:     ) external onlyRole(Roles.BRIDGER_ROLE) whenNotPaused {

90:     ) external onlyRole(Roles.WITHDRAWER_ROLE) {

115:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

14: abstract contract PausableWithAccessControl is

32:     function emergencyPause() external onlyRole(Roles.PAUSER_ROLE) {

43:     function emergencyUnpause() external onlyRole(Roles.UNPAUSER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

114:     function setEarmarks(Earmark[] calldata earmarks) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

197:     ) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

215:     ) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

25: contract SwapAutomator is ITypeAndVersion, PausableWithAccessControl, AutomationCompatible {

147:     ) PausableWithAccessControl(params.adminRoleTransferDelay, params.admin) {

175:     function setForwarder(address forwarder) external onlyRole(DEFAULT_ADMIN_ROLE) {

198:     ) external onlyRole(Roles.ASSET_ADMIN_ROLE) {

256:     function setFeeAggregator(address feeAggregator) external onlyRole(DEFAULT_ADMIN_ROLE) {

277:     function setDeadlineDelay(uint96 deadlineDelay) external onlyRole(Roles.ASSET_ADMIN_ROLE) {

364:     function setLinkReceiver(address linkReceiver) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="M-2"></a>[M-2] `increaseAllowance/decreaseAllowance` won't work on mainnet for USDT
On mainnet, the mitigation to be compatible with `increaseAllowance/decreaseAllowance` isn't applied: https://etherscan.io/token/0xdac17f958d2ee523a2206206994597c13d831ec7#code, meaning it reverts on setting a non-zero & non-max allowance, unless the allowance is already zero.

*Instances (4)*:
```solidity
File: ./src/FeeAggregator.sol

258:         IERC20(address(i_linkToken)).safeIncreaseAllowance(CCIPReceiver.getRouter(), fees);

282:             IERC20(asset).safeIncreaseAllowance(CCIPReceiver.getRouter(), bridgeAssetAmounts[i].amount);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/SwapAutomator.sol

534:                 IERC20(asset).safeIncreaseAllowance(address(i_uniswapRouter), amountIn);

545:                     IERC20(asset).safeDecreaseAllowance(address(i_uniswapRouter), amountIn);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="M-3"></a>[M-3] Direct `supportsInterface()` calls may cause caller to revert
Calling `supportsInterface()` on a contract that doesn't implement the ERC-165 standard will result in the call reverting. Even if the caller does support the function, the contract may be malicious and consume all of the transaction's available gas. Call it via a low-level [staticcall()](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f959d7e4e6ee0b022b41e5b644c79369869d8411/contracts/utils/introspection/ERC165Checker.sol#L119), with a fixed amount of gas, and check the return code, or use OpenZeppelin's [`ERC165Checker.supportsInterface()`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f959d7e4e6ee0b022b41e5b644c79369869d8411/contracts/utils/introspection/ERC165Checker.sol#L36-L39).

*Instances (3)*:
```solidity
File: ./src/FeeAggregator.sol

488:             super.supportsInterface(interfaceId);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

126:         if (!IERC165(newFeeAggregator).supportsInterface(type(IFeeAggregator).interfaceId)) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

38:         return interfaceId == type(IAccessControlEnumerable).interfaceId || super.supportsInterface(interfaceId);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

