# Report


## Gas Optimizations


| |Issue|Instances|
|-|:-|:-:|
| [GAS-1](#GAS-1) | `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings) | 1 |
| [GAS-2](#GAS-2) | Cache array length outside of loop | 22 |
| [GAS-3](#GAS-3) | For Operations that will not overflow, you could use unchecked | 145 |
| [GAS-4](#GAS-4) | Avoid contract existence checks by using low level calls | 5 |
| [GAS-5](#GAS-5) | Functions guaranteed to revert when called by normal users can be marked `payable` | 2 |
| [GAS-6](#GAS-6) | `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`) | 1 |
| [GAS-7](#GAS-7) | Using `private` rather than `public` for constants, saves gas | 12 |
| [GAS-8](#GAS-8) | Use of `this` instead of marking as `public` an `external` function | 1 |
| [GAS-9](#GAS-9) | Increments/decrements can be unchecked in for-loops | 22 |
| [GAS-10](#GAS-10) | Use != 0 instead of > 0 for unsigned integer comparison | 3 |
### <a name="GAS-1"></a>[GAS-1] `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings)
This saves **16 gas per instance.**

*Instances (1)*:
```solidity
File: ./src/Reserves.sol

136:         totalAmountOwed += uint256(int256(newBalance));

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

### <a name="GAS-2"></a>[GAS-2] Cache array length outside of loop
If not cached, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).

*Instances (22)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

42:     for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

171:     for (uint256 i; i < assets.length; ++i) {

188:     for (uint256 i; i < assets.length; ++i) {

268:     for (uint256 i; i < bridgeAssetAmounts.length; ++i) {

325:     for (uint256 i; i < assetsToRemove.length; ++i) {

333:     for (uint256 i; i < assetsToAdd.length; ++i) {

361:     for (uint256 i; i < assets.length; ++i) {

399:     for (uint256 i; i < receiversToRemove.length; ++i) {

403:       for (uint256 j; j < receivers.length; ++j) {

418:     for (uint256 i; i < receiversToAdd.length; ++i) {

426:       for (uint256 j; j < receivers.length; ++j) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

100:     for (uint256 i = 0; i < assets.length; ++i) {

130:     for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

116:     for (uint256 i; i < earmarks.length; ++i) {

180:     for (uint256 i; i < serviceProviders.length; ++i) {

215:     for (uint256 i; i < serviceProviders.length; ++i) {

237:     for (uint256 i; i < serviceProviders.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

235:     for (uint256 i; i < assetsToRemove.length; ++i) {

254:     for (uint256 i; i < assetSwapParamsArgs.assetsSwapParams.length; ++i) {

456:     for (uint256 i; i < allowlistedAssets.length; ++i) {

552:     for (uint256 i; i < swapInputs.length; ++i) {

563:     for (uint256 i; i < swapInputs.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-3"></a>[GAS-3] For Operations that will not overflow, you could use unchecked

*Instances (145)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

4: import {PausableWithAccessControl} from "src/PausableWithAccessControl.sol";

5: import {Errors} from "src/libraries/Errors.sol";

7: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

8: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

42:     for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

4: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

5: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

6: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

8: import {EmergencyWithdrawer} from "src/EmergencyWithdrawer.sol";

9: import {LinkReceiver} from "src/LinkReceiver.sol";

10: import {NativeTokenReceiver} from "src/NativeTokenReceiver.sol";

11: import {PausableWithAccessControl} from "src/PausableWithAccessControl.sol";

12: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

13: import {EnumerableBytesSet} from "src/libraries/EnumerableBytesSet.sol";

14: import {Errors} from "src/libraries/Errors.sol";

15: import {Roles} from "src/libraries/Roles.sol";

17: import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";

18: import {ILinkAvailable} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol";

19: import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";

20: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

21: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

103:     address admin; // ──────────────────╮ The initial contract admin

104:     uint48 adminRoleTransferDelay; // ──╯ The min seconds before the admin address can be transferred

105:     address linkToken; // The LINK token

106:     address ccipRouterClient; // The CCIP Router client

107:     address wrappedNativeToken; // The wrapped native token

112:     uint64 remoteChainSelector; // ──╮ The remote chain selector to allowlist

113:     bytes[] receivers; // ───────────╯ The list of encoded remote receivers

171:     for (uint256 i; i < assets.length; ++i) {

188:     for (uint256 i; i < assets.length; ++i) {

268:     for (uint256 i; i < bridgeAssetAmounts.length; ++i) {

325:     for (uint256 i; i < assetsToRemove.length; ++i) {

333:     for (uint256 i; i < assetsToAdd.length; ++i) {

361:     for (uint256 i; i < assets.length; ++i) {

399:     for (uint256 i; i < receiversToRemove.length; ++i) {

403:       for (uint256 j; j < receivers.length; ++j) {

418:     for (uint256 i; i < receiversToAdd.length; ++i) {

426:       for (uint256 j; j < receivers.length; ++j) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

6: import {EmergencyWithdrawer} from "src/EmergencyWithdrawer.sol";

7: import {LinkReceiver} from "src/LinkReceiver.sol";

8: import {NativeTokenReceiver} from "src/NativeTokenReceiver.sol";

9: import {Errors} from "src/libraries/Errors.sol";

10: import {Roles} from "src/libraries/Roles.sol";

12: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

13: import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

14: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

15: import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

100:     for (uint256 i = 0; i < assets.length; ++i) {

130:     for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/LinkReceiver.sol

4: import {Errors} from "src/libraries/Errors.sol";

6: import {IERC677Receiver} from "@chainlink/contracts/src/v0.8/shared/token/ERC677/IERC677Receiver.sol";

7: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/LinkReceiver.sol)

```solidity
File: ./src/NativeTokenReceiver.sol

4: import {IWERC20} from "@chainlink/contracts/src/v0.8/shared/interfaces/IWERC20.sol";

5: import {Errors} from "src/libraries/Errors.sol";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/NativeTokenReceiver.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

4: import {IPausable} from "src/interfaces/IPausable.sol";

6: import {Roles} from "src/libraries/Roles.sol";

9:   "@openzeppelin/contracts/access/extensions/AccessControlDefaultAdminRules.sol";

10: import {IAccessControlEnumerable} from "@openzeppelin/contracts/access/extensions/IAccessControlEnumerable.sol";

11: import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

12: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

4: import {EmergencyWithdrawer} from "src/EmergencyWithdrawer.sol";

5: import {LinkReceiver} from "src/LinkReceiver.sol";

6: import {Errors} from "src/libraries/Errors.sol";

7: import {Roles} from "src/libraries/Roles.sol";

9: import {ILinkAvailable} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol";

10: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

11: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

12: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

13: import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

53:     uint48 adminRoleTransferDelay; // ─╮ The minimum amount of seconds that must pass before

55:     address admin; // ─────────────────╯ The address of the admin

56:     address linkToken; //                The address of the LINK token

63:     address serviceProvider; // ─╮ The address of the service provider

64:     int96 amountLinkOwed; // ────╯ The amount of LINK in juels owed to the service provider. This value can be

66:     bytes data; //                 Arbitrary data associated with the earmark

73:     int96 linkBalance; // ─────╮ LINK balance in juels owed to the service provider. This value

75:     uint96 earmarkCounter; // ─╯ Running counter used to track unique earmark IDs. The value represents the

116:     for (uint256 i; i < earmarks.length; ++i) {

126:       int96 newBalance = currentBalance + amountLinkOwed;

132:         totalAmountOwed -= uint256(int256(currentBalance));

136:         totalAmountOwed += uint256(int256(newBalance));

139:       uint256 earmarkCounter = ++serviceProviderInfo.earmarkCounter;

180:     for (uint256 i; i < serviceProviders.length; ++i) {

194:       totalAmountOwed -= linkWithdrawn;

215:     for (uint256 i; i < serviceProviders.length; ++i) {

237:     for (uint256 i; i < serviceProviders.length; ++i) {

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

14:   "@chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol";

15: import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

16: import {ITypeAndVersion} from "@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol";

17: import {LinkTokenInterface} from "@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol";

18: import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

19: import {IERC20Metadata} from "@openzeppelin/contracts/interfaces/IERC20Metadata.sol";

20: import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

21: import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

22: import {SafeCast} from "@openzeppelin/contracts/utils/math/SafeCast.sol";

23: import {IV3SwapRouter} from "@uniswap/swap-router-contracts/contracts/interfaces/IV3SwapRouter.sol";

24: import {IQuoterV2} from "@uniswap/v3-periphery/contracts/interfaces/IQuoterV2.sol";

113:     uint48 adminRoleTransferDelay; // ─╮ The minimum amount of seconds that must pass before the admin address can be

115:     address admin; // ─────────────────╯ The initial contract admin

116:     uint96 deadlineDelay; // ──────────╮ The maximum amount of seconds the swap transaction is valid for

117:     address linkToken; // ─────────────╯ The Link token

118:     address feeAggregator; //            The Fee Aggregator

119:     address linkUsdFeed; //              The link usd feed

120:     address uniswapRouter; //            The address of the Uniswap router

121:     address uniswapQuoterV2; //          The address of the Uniswap QuoterV2

122:     address linkReceiver; //             The address that will receive converted LINK

127:     AggregatorV3Interface oracle; // ─╮ The asset usd oracle

128:     uint16 maxSlippage; //            │ The maximum allowed slippage for the swap in basis points

129:     uint16 maxPriceDeviation; //      │  The maximum allowed one-side deviation of actual swapped out amount

131:     uint64 swapInterval; // ──────────╯ The minimum interval between swaps

132:     uint128 minSwapSizeUsd; // ───────╮ The minimum swap size expressed in USD 8 decimals

133:     uint128 maxSwapSizeUsd; // ───────╯ The maximum swap size expressed in USD 8 decimals

134:     bytes path; //                      The swap path

139:     address[] assets; // The list of assets

140:     SwapParams[] assetsSwapParams; // The list of swap parameters

235:     for (uint256 i; i < assetsToRemove.length; ++i) {

254:     for (uint256 i; i < assetSwapParamsArgs.assetsSwapParams.length; ++i) {

456:     for (uint256 i; i < allowlistedAssets.length; ++i) {

467:       if (assetPrice == 0 || updatedAt < block.timestamp - STALENESS_THRESHOLD) continue;

468:       uint256 assetUnit = 10 ** IERC20Metadata(asset).decimals();

471:       uint256 availableAssetUsdValue = IERC20(asset).balanceOf(address(s_feeAggregator)) * assetPrice;

476:         availableAssetUsdValue >= swapParams.minSwapSizeUsd * assetUnit

477:           && block.timestamp - s_latestSwapTimestamp[asset] >= swapParams.swapInterval

480:         uint256 swapAmountIn = Math.min(swapParams.maxSwapSizeUsd * assetUnit, availableAssetUsdValue) / assetPrice;

495:               < amountOutCLPriceFeedQuote.percentMul(PercentageMath.PERCENTAGE_FACTOR - swapParams.maxSlippage)

501:         swapInputs[idx++] = IV3SwapRouter.ExactInputParams({

508:             PercentageMath.PERCENTAGE_FACTOR - swapParams.maxSlippage

523:       return (true, abi.encode(swapInputs, block.timestamp + s_deadlineDelay));

552:     for (uint256 i; i < swapInputs.length; ++i) {

563:     for (uint256 i; i < swapInputs.length; ++i) {

634:       amountOut < linkAmountOutFromPriceFeed.percentMul(PercentageMath.PERCENTAGE_FACTOR - swapParams.maxPriceDeviation)

661:     if (updatedAt < block.timestamp - STALENESS_THRESHOLD) {

684:       return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

686:       return (assetAmount * assetPrice) / linkUSDPrice / 10 ** (tokenDecimals - LINK_DECIMALS);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

```solidity
File: ./src/libraries/EnumerableBytesSet.sol

50:       uint256 valueIndex = position - 1;

51:       uint256 lastIndex = set._values.length - 1;

131:     assembly ("memory-safe") {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/EnumerableBytesSet.sol)

### <a name="GAS-4"></a>[GAS-4] Avoid contract existence checks by using low level calls
Prior to 0.8.10 the compiler inserted extra code, including `EXTCODESIZE` (**100 gas**), to check for contract existence for external function calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value. Similar behavior can be achieved in earlier versions by using low-level calls, since low level calls never check for contract existence

*Instances (5)*:
```solidity
File: ./src/FeeAggregator.sol

243:     uint256 currentBalance = i_linkToken.balanceOf(address(this));

300:     return int256(i_linkToken.balanceOf(address(this)));

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/Reserves.sol

147:     uint256 currentReserves = i_linkToken.balanceOf(address(this));

271:     return int256(i_linkToken.balanceOf(address(this)));

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

471:       uint256 availableAssetUsdValue = IERC20(asset).balanceOf(address(s_feeAggregator)) * assetPrice;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-5"></a>[GAS-5] Functions guaranteed to revert when called by normal users can be marked `payable`
If a function modifier such as `onlyOwner` is used, the function will revert if a normal user tries to pay the function. Marking the function as `payable` will lower the gas cost for legitimate callers because the compiler will not include checks for whether a payment was provided.

*Instances (2)*:
```solidity
File: ./src/PausableWithAccessControl.sol

33:   function emergencyPause() external onlyRole(Roles.PAUSER_ROLE) {

46:   function emergencyUnpause() external onlyRole(Roles.UNPAUSER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

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

42:     for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

### <a name="GAS-7"></a>[GAS-7] Using `private` rather than `public` for constants, saves gas
If needed, the values can be read from the verified contract source code, or if there are multiple values there can be a single getter function that [returns a tuple](https://github.com/code-423n4/2022-08-frax/blob/90f55a9ce4e25bceed3a74290b854341d8de6afa/src/contracts/FraxlendPair.sol#L156-L178) of the values of all currently-public constants. Saves **3406-3606 gas** in deployment gas due to the compiler not having to create non-payable getter functions for deployment calldata, not having to store the bytes of the value outside of where it's used, and not adding another entry to the method ID table

*Instances (12)*:
```solidity
File: ./src/FeeAggregator.sol

117:   string public constant override typeAndVersion = "Fee Aggregator 1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

55:   string public constant override typeAndVersion = "FeeRouter v1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/NativeTokenReceiver.sol

17:   uint256 public constant MIN_GAS_FOR_RECEIVE = 2300;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/NativeTokenReceiver.sol)

```solidity
File: ./src/Reserves.sol

80:   string public constant override typeAndVersion = "Reserves 1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

144:   string public constant override typeAndVersion = "Uniswap V3 Swap Automator 1.0.0";

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

```solidity
File: ./src/libraries/Roles.sol

9:   bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

13:   bytes32 public constant UNPAUSER_ROLE = keccak256("UNPAUSER_ROLE");

18:   bytes32 public constant ASSET_ADMIN_ROLE = keccak256("ASSET_ADMIN_ROLE");

22:   bytes32 public constant BRIDGER_ROLE = keccak256("BRIDGER_ROLE");

26:   bytes32 public constant EARMARK_MANAGER_ROLE = keccak256("EARMARK_MANAGER_ROLE");

30:   bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

34:   bytes32 public constant SWAPPER_ROLE = keccak256("SWAPPER_ROLE");

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Roles.sol)

### <a name="GAS-8"></a>[GAS-8] Use of `this` instead of marking as `public` an `external` function
Using `this.` is like making an expensive external call. Consider marking the called function as public

*Saves around 2000 gas per instance*

*Instances (1)*:
```solidity
File: ./src/SwapAutomator.sol

591:         try this.swapWithPriceFeedValidation(swapInputs[i], asset, linkPriceFromFeed) returns (uint256 amountOut) {

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

*Instances (22)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

42:     for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

171:     for (uint256 i; i < assets.length; ++i) {

188:     for (uint256 i; i < assets.length; ++i) {

268:     for (uint256 i; i < bridgeAssetAmounts.length; ++i) {

325:     for (uint256 i; i < assetsToRemove.length; ++i) {

333:     for (uint256 i; i < assetsToAdd.length; ++i) {

361:     for (uint256 i; i < assets.length; ++i) {

399:     for (uint256 i; i < receiversToRemove.length; ++i) {

403:       for (uint256 j; j < receivers.length; ++j) {

418:     for (uint256 i; i < receiversToAdd.length; ++i) {

426:       for (uint256 j; j < receivers.length; ++j) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

100:     for (uint256 i = 0; i < assets.length; ++i) {

130:     for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/Reserves.sol

116:     for (uint256 i; i < earmarks.length; ++i) {

180:     for (uint256 i; i < serviceProviders.length; ++i) {

215:     for (uint256 i; i < serviceProviders.length; ++i) {

237:     for (uint256 i; i < serviceProviders.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

235:     for (uint256 i; i < assetsToRemove.length; ++i) {

254:     for (uint256 i; i < assetSwapParamsArgs.assetsSwapParams.length; ++i) {

456:     for (uint256 i; i < allowlistedAssets.length; ++i) {

552:     for (uint256 i; i < swapInputs.length; ++i) {

563:     for (uint256 i; i < swapInputs.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="GAS-10"></a>[GAS-10] Use != 0 instead of > 0 for unsigned integer comparison

*Instances (3)*:
```solidity
File: ./src/Reserves.sol

131:       if (currentBalance > 0) {

134:       if (newBalance > 0) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

522:     if (idx > 0) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)


## Non Critical Issues


| |Issue|Instances|
|-|:-|:-:|
| [NC-1](#NC-1) | `constant`s should be defined rather than using magic numbers | 3 |
| [NC-2](#NC-2) | Control structures do not follow the Solidity Style Guide | 21 |
| [NC-3](#NC-3) | Unused `error` definition | 12 |
| [NC-4](#NC-4) | Functions should not be longer than 50 lines | 39 |
| [NC-5](#NC-5) | Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor | 3 |
| [NC-6](#NC-6) | Consider using named mappings | 1 |
| [NC-7](#NC-7) | Take advantage of Custom Error's return value property | 44 |
| [NC-8](#NC-8) | Use Underscores for Number Literals (add an underscore every 3 digits) | 1 |
| [NC-9](#NC-9) | Variables need not be initialized to zero | 3 |
### <a name="NC-1"></a>[NC-1] `constant`s should be defined rather than using magic numbers
Even [assembly](https://github.com/code-423n4/2022-05-opensea-seaport/blob/9d7ce4d08bf3c3010304a0476a785c70c0e90ae7/contracts/lib/TokenTransferrer.sol#L35-L39) can benefit from using readable constants instead of hex/numeric literals

*Instances (3)*:
```solidity
File: ./src/SwapAutomator.sol

468:       uint256 assetUnit = 10 ** IERC20Metadata(asset).decimals();

684:       return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

686:       return (assetAmount * assetPrice) / linkUSDPrice / 10 ** (tokenDecimals - LINK_DECIMALS);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-2"></a>[NC-2] Control structures do not follow the Solidity Style Guide
See the [control structures](https://docs.soliditylang.org/en/latest/style-guide.html#control-structures) section of the Solidity Style Guide

*Instances (21)*:
```solidity
File: ./src/FeeAggregator.sol

12: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

28:   IFeeAggregator,

153:     return interfaceId == type(IFeeAggregator).interfaceId || PausableWithAccessControl.supportsInterface(interfaceId);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

58:   IFeeAggregator private s_feeAggregator;

71:     s_feeAggregator = IFeeAggregator(params.feeAggregator);

92:     IFeeAggregator feeAggregator = s_feeAggregator;

122:     IFeeAggregator feeAggregator = s_feeAggregator;

185:     s_feeAggregator = IFeeAggregator(newFeeAggregator);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/LinkReceiver.sol

40:     if (msg.sender != address(i_linkToken)) revert SenderNotLinkToken();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/LinkReceiver.sol)

```solidity
File: ./src/SwapAutomator.sol

4: import {IFeeAggregator} from "src/interfaces/IFeeAggregator.sol";

169:   IFeeAggregator private s_feeAggregator;

183:     if (

263:       if (

307:     if (feeAggregator == address(0)) revert Errors.InvalidZeroAddress();

467:       if (assetPrice == 0 || updatedAt < block.timestamp - STALENESS_THRESHOLD) continue;

475:       if (

493:           if (

557:     IFeeAggregator feeAggregator = s_feeAggregator;

633:     if (

660:     if (answer == 0) revert Errors.ZeroOracleData();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-3"></a>[NC-3] Unused `error` definition
Note that there may be cases where an error superficially appears to be used, but this is only because there are multiple definitions of the error in different files. In such cases, the error definition should be moved into a separate file. The instances below are the unused definitions.

*Instances (12)*:
```solidity
File: ./src/libraries/Errors.sol

8:   error InvalidZeroAddress();

10:   error EmptyList();

13:   error FeeAggregatorNotUpdated();

15:   error ForwarderNotUpdated();

17:   error ZeroOracleData();

20:   error StaleOracleData();

23:   error AccessForbidden();

25:   error InvalidZeroAmount();

27:   error ArrayLengthMismatch();

31:   error AssetNotAllowlisted(address asset);

33:   error AssetAllowlisted(address asset);

36:   error ValueEqOriginalValue();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/Errors.sol)

### <a name="NC-4"></a>[NC-4] Functions should not be longer than 50 lines
Overly complex code can make understanding functionality more difficult, try to further modularize your code to ensure readability 

*Instances (39)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

52:   function emergencyWithdrawNative(address payable to, uint256 amount) external whenPaused onlyRole(DEFAULT_ADMIN_ROLE) {

62:   function _transferNative(address payable to, uint256 amount) internal {

80:   function _validateAssetTransferInputs(address[] calldata assets, uint256[] calldata amounts) internal pure {

95:   function _transferAsset(address to, address asset, uint256 amount) internal {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

198:   function getAllowlistedAssets() external view returns (address[] memory allowlistedAssets) {

204:   function getAllowlistedDestinationChains() external view returns (uint256[] memory allowlistedDestinationChains) {

296:   function linkAvailableForPayment() external view returns (int256 linkBalance) {

305:   function getRouter() public view returns (address ccipRouter) {

379:   function withdrawNative(address payable to, uint256 amount) external onlyRole(Roles.WITHDRAWER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

143:   function withdrawNative(address payable to, uint256 amount) external onlyRole(Roles.WITHDRAWER_ROLE) {

192:   function getFeeAggregator() external view returns (IFeeAggregator feeAggregator) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/LinkReceiver.sol

39:   function onTokenTransfer(address, uint256, bytes calldata) external view {

45:   function getLinkToken() external view returns (IERC20 linkToken) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/LinkReceiver.sol)

```solidity
File: ./src/NativeTokenReceiver.sol

75:   function getWrappedNativeToken() external view returns (IWERC20 wrappedNativeToken) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/NativeTokenReceiver.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

33:   function emergencyPause() external onlyRole(Roles.PAUSER_ROLE) {

46:   function emergencyUnpause() external onlyRole(Roles.UNPAUSER_ROLE) {

51:   function getRoleMember(bytes32 role, uint256 index) external view override returns (address) {

72:   function _grantRole(bytes32 role, address account) internal virtual override returns (bool) {

81:   function _revokeRole(bytes32 role, address account) internal virtual override returns (bool) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

158:   function getTotalLinkAmountOwed() external view returns (uint256 totalLinkAmountOwed) {

267:   function linkAvailableForPayment() external view returns (int256 linkBalance) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

348:   function getLINKUsdFeed() external view returns (AggregatorV3Interface linkUsdFeed) {

354:   function getForwarder() external view returns (address forwarder) {

360:   function getLinkToken() external view returns (LinkTokenInterface linkToken) {

366:   function getUniswapRouter() external view returns (IV3SwapRouter uniswapRouter) {

372:   function getUniswapQuoterV2() external view returns (IQuoterV2 uniswapQuoter) {

378:   function getFeeAggregator() external view returns (IFeeAggregator feeAggregator) {

393:   function getDeadlineDelay() external view returns (uint96 deadlineDelay) {

407:   function getLinkReceiver() external view returns (address linkReceiver) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

```solidity
File: ./src/interfaces/IFeeAggregator.sol

11:   function transferForSwap(address to, address[] calldata assets, uint256[] calldata amounts) external;

15:   function getAllowlistedAssets() external view returns (address[] memory allowlistedAssets);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/interfaces/IFeeAggregator.sol)

```solidity
File: ./src/libraries/EnumerableBytesSet.sol

16:   function add(BytesSet storage set, bytes memory value) internal returns (bool) {

20:   function _add(BytesSet storage set, bytes memory value) private returns (bool) {

36:   function remove(BytesSet storage set, bytes memory value) internal returns (bool) {

40:   function _remove(BytesSet storage set, bytes memory value) private returns (bool) {

78:   function contains(BytesSet storage set, bytes memory value) internal view returns (bool) {

82:   function _contains(BytesSet storage set, bytes memory value) private view returns (bool) {

108:   function at(BytesSet storage set, uint256 index) internal view returns (bytes memory) {

112:   function _at(BytesSet storage set, uint256 index) private view returns (bytes memory) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/libraries/EnumerableBytesSet.sol)

### <a name="NC-5"></a>[NC-5] Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor
If a function is supposed to be access-controlled, a `modifier` should be used instead of a `require/if` statement for more readability.

*Instances (3)*:
```solidity
File: ./src/LinkReceiver.sol

40:     if (msg.sender != address(i_linkToken)) revert SenderNotLinkToken();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/LinkReceiver.sol)

```solidity
File: ./src/SwapAutomator.sol

534:     if (msg.sender != s_forwarder) {

623:     if (msg.sender != address(this)) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-6"></a>[NC-6] Consider using named mappings
Consider moving to solidity version 0.8.18 or later, and using [named mappings](https://ethereum.stackexchange.com/questions/51629/how-to-name-the-arguments-in-mapping/145555#145555) to make it easier to understand the purpose of each mapping

*Instances (1)*:
```solidity
File: ./src/FeeAggregator.sol

132:   mapping(uint64 => EnumerableBytesSet.BytesSet) private s_allowlistedReceivers;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

### <a name="NC-7"></a>[NC-7] Take advantage of Custom Error's return value property
An important feature of Custom Error is that values such as address, tokenID, msg.value can be written inside the () sign, this kind of approach provides a serious advantage in debugging and examining the revert details of dapps such as tenderly.

*Instances (44)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

64:       revert Errors.InvalidZeroAddress();

67:       revert Errors.InvalidZeroAmount();

82:       revert Errors.EmptyList();

85:       revert Errors.ArrayLengthMismatch();

97:       revert Errors.InvalidZeroAddress();

100:       revert Errors.InvalidZeroAmount();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

142:       revert Errors.InvalidZeroAddress();

234:       revert Errors.EmptyList();

336:         revert Errors.InvalidZeroAddress();

421:         revert InvalidChainSelector();

429:           revert Errors.InvalidZeroAddress();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

68:       revert Errors.InvalidZeroAddress();

176:       revert Errors.InvalidZeroAddress();

179:       revert Errors.FeeAggregatorNotUpdated();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/LinkReceiver.sol

25:       revert Errors.InvalidZeroAddress();

40:     if (msg.sender != address(i_linkToken)) revert SenderNotLinkToken();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/LinkReceiver.sol)

```solidity
File: ./src/NativeTokenReceiver.sol

37:       revert ZeroBalance();

65:       revert Errors.ValueEqOriginalValue();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/NativeTokenReceiver.sol)

```solidity
File: ./src/Reserves.sol

111:       revert Errors.EmptyList();

175:       revert Errors.EmptyList();

212:       revert Errors.EmptyList();

217:         revert Errors.InvalidZeroAddress();

234:       revert Errors.EmptyList();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

187:       revert Errors.InvalidZeroAddress();

212:       revert Errors.InvalidZeroAddress();

215:       revert Errors.ForwarderNotUpdated();

244:       revert AssetsSwapParamsMismatch();

258:         revert Errors.InvalidZeroAddress();

261:         revert InvalidSlippage();

267:         revert InvalidMaxPriceDeviation();

270:         revert EmptySwapPath();

307:     if (feeAggregator == address(0)) revert Errors.InvalidZeroAddress();

309:       revert Errors.FeeAggregatorNotUpdated();

333:       revert DeadlineDelayNotUpdated();

430:       revert Errors.InvalidZeroAddress();

433:       revert LinkReceiverNotUpdated();

535:       revert Errors.AccessForbidden();

568:         revert InvalidSwapPath();

572:         revert FeeRecipientMismatch();

608:       revert AllSwapsFailed();

624:       revert Errors.AccessForbidden();

636:       revert InsufficientAmountReceived();

660:     if (answer == 0) revert Errors.ZeroOracleData();

662:       revert Errors.StaleOracleData();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="NC-8"></a>[NC-8] Use Underscores for Number Literals (add an underscore every 3 digits)

*Instances (1)*:
```solidity
File: ./src/NativeTokenReceiver.sol

17:   uint256 public constant MIN_GAS_FOR_RECEIVE = 2300;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/NativeTokenReceiver.sol)

### <a name="NC-9"></a>[NC-9] Variables need not be initialized to zero
The default value for variables is zero, so initializing them to zero is superfluous.

*Instances (3)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

42:     for (uint256 i = 0; i < assets.length; i++) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeRouter.sol

100:     for (uint256 i = 0; i < assets.length; ++i) {

130:     for (uint256 i = 0; i < assets.length; ++i) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)


## Low Issues


| |Issue|Instances|
|-|:-|:-:|
| [L-1](#L-1) | `decimals()` is not a part of the ERC-20 standard | 2 |
| [L-2](#L-2) | Division by zero not prevented | 2 |
| [L-3](#L-3) | External call recipient may consume all transaction gas | 1 |
| [L-4](#L-4) | Signature use at deadlines should be allowed | 3 |
| [L-5](#L-5) | Loss of precision | 2 |
| [L-6](#L-6) | Solidity version 0.8.20+ may not work on other chains due to `PUSH0` | 2 |
| [L-7](#L-7) | File allows a version of solidity that is susceptible to an assembly optimizer bug | 2 |
### <a name="L-1"></a>[L-1] `decimals()` is not a part of the ERC-20 standard
The `decimals()` function is not a part of the [ERC-20 standard](https://eips.ethereum.org/EIPS/eip-20), and was added later as an [optional extension](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol). As such, some valid ERC20 tokens do not support this interface, so it is unsafe to blindly cast all tokens to this interface, and then call this function.

*Instances (2)*:
```solidity
File: ./src/SwapAutomator.sol

468:       uint256 assetUnit = 10 ** IERC20Metadata(asset).decimals();

681:     uint256 tokenDecimals = asset.decimals();

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-2"></a>[L-2] Division by zero not prevented
The divisions below take an input parameter which does not have any zero-value checks, which may lead to the functions reverting when zero is passed.

*Instances (2)*:
```solidity
File: ./src/SwapAutomator.sol

480:         uint256 swapAmountIn = Math.min(swapParams.maxSwapSizeUsd * assetUnit, availableAssetUsdValue) / assetPrice;

684:       return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-3"></a>[L-3] External call recipient may consume all transaction gas
There is no limit specified on the amount of gas used, so the recipient can use up all of the transaction's gas, causing it to revert. Use `addr.call{gas: <amount>}("")` or [this](https://github.com/nomad-xyz/ExcessivelySafeCall) library instead.

*Instances (1)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

70:     (bool success, bytes memory data) = to.call{value: amount}("");

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

### <a name="L-4"></a>[L-4] Signature use at deadlines should be allowed
According to [EIP-2612](https://github.com/ethereum/EIPs/blob/71dc97318013bf2ac572ab63fab530ac9ef419ca/EIPS/eip-2612.md?plain=1#L58), signatures used on exactly the deadline timestamp are supposed to be allowed. While the signature may or may not be used for the exact EIP-2612 use case (transfer approvals), for consistency's sake, all deadlines should follow this semantic. If the timestamp is an expiration rather than a deadline, consider whether it makes more sense to include the expiration timestamp as a valid timestamp, as is done for deadlines.

*Instances (3)*:
```solidity
File: ./src/SwapAutomator.sol

467:       if (assetPrice == 0 || updatedAt < block.timestamp - STALENESS_THRESHOLD) continue;

541:     if (deadline < block.timestamp) {

661:     if (updatedAt < block.timestamp - STALENESS_THRESHOLD) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-5"></a>[L-5] Loss of precision
Division by large numbers may result in the result being zero, due to solidity not supporting fractions. Consider requiring a minimum amount for the numerator to ensure that it is always larger than the denominator

*Instances (2)*:
```solidity
File: ./src/SwapAutomator.sol

684:       return (assetAmount * assetPrice * 10 ** (LINK_DECIMALS - tokenDecimals)) / linkUSDPrice;

686:       return (assetAmount * assetPrice) / linkUSDPrice / 10 ** (tokenDecimals - LINK_DECIMALS);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="L-6"></a>[L-6] Solidity version 0.8.20+ may not work on other chains due to `PUSH0`
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

### <a name="L-7"></a>[L-7] File allows a version of solidity that is susceptible to an assembly optimizer bug
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
| [M-1](#M-1) | Centralization Risk for trusted owners | 29 |
| [M-2](#M-2) | `increaseAllowance/decreaseAllowance` won't work on mainnet for USDT | 4 |
| [M-3](#M-3) | Direct `supportsInterface()` calls may cause caller to revert | 3 |
### <a name="M-1"></a>[M-1] Centralization Risk for trusted owners

#### Impact:
Contracts have owners with privileged rights to perform admin tasks and need to be trusted to not perform malicious updates or drain funds.

*Instances (29)*:
```solidity
File: ./src/EmergencyWithdrawer.sol

11: abstract contract EmergencyWithdrawer is PausableWithAccessControl {

27:   constructor(uint48 adminRoleTransferDelay, address admin) PausableWithAccessControl(adminRoleTransferDelay, admin) {}

39:   ) external whenPaused onlyRole(DEFAULT_ADMIN_ROLE) {

52:   function emergencyWithdrawNative(address payable to, uint256 amount) external whenPaused onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/EmergencyWithdrawer.sol)

```solidity
File: ./src/FeeAggregator.sol

168:   ) external whenNotPaused onlyRole(Roles.SWAPPER_ROLE) {

228:   ) external whenNotPaused onlyRole(Roles.BRIDGER_ROLE) returns (bytes32 messageId) {

324:   ) external onlyRole(Roles.ASSET_ADMIN_ROLE) whenNotPaused {

358:   ) external onlyRole(Roles.WITHDRAWER_ROLE) {

379:   function withdrawNative(address payable to, uint256 amount) external onlyRole(Roles.WITHDRAWER_ROLE) {

398:   ) external onlyRole(DEFAULT_ADMIN_ROLE) whenNotPaused {

449:   ) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

89:   ) external onlyRole(Roles.BRIDGER_ROLE) whenNotPaused {

119:   ) external onlyRole(Roles.WITHDRAWER_ROLE) {

143:   function withdrawNative(address payable to, uint256 amount) external onlyRole(Roles.WITHDRAWER_ROLE) {

168:   ) external onlyRole(DEFAULT_ADMIN_ROLE) {

203:   ) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

15: abstract contract PausableWithAccessControl is

33:   function emergencyPause() external onlyRole(Roles.PAUSER_ROLE) {

46:   function emergencyUnpause() external onlyRole(Roles.UNPAUSER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

```solidity
File: ./src/Reserves.sol

109:   ) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

210:   ) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

232:   ) external onlyRole(Roles.EARMARK_MANAGER_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/Reserves.sol)

```solidity
File: ./src/SwapAutomator.sol

28: contract SwapAutomator is ITypeAndVersion, PausableWithAccessControl, AutomationCompatible {

182:   ) PausableWithAccessControl(params.adminRoleTransferDelay, params.admin) {

210:   ) external onlyRole(DEFAULT_ADMIN_ROLE) {

233:   ) external onlyRole(Roles.ASSET_ADMIN_ROLE) {

298:   ) external onlyRole(DEFAULT_ADMIN_ROLE) {

323:   ) external onlyRole(Roles.ASSET_ADMIN_ROLE) {

419:   ) external onlyRole(DEFAULT_ADMIN_ROLE) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="M-2"></a>[M-2] `increaseAllowance/decreaseAllowance` won't work on mainnet for USDT
On mainnet, the mitigation to be compatible with `increaseAllowance/decreaseAllowance` isn't applied: https://etherscan.io/token/0xdac17f958d2ee523a2206206994597c13d831ec7#code, meaning it reverts on setting a non-zero & non-max allowance, unless the allowance is already zero.

*Instances (4)*:
```solidity
File: ./src/FeeAggregator.sol

249:     IERC20(address(i_linkToken)).safeIncreaseAllowance(address(i_ccipRouter), fees);

274:       IERC20(asset).safeIncreaseAllowance(address(i_ccipRouter), bridgeAssetAmounts[i].amount);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/SwapAutomator.sol

587:         IERC20(asset).safeIncreaseAllowance(address(i_uniswapRouter), amountIn);

596:           IERC20(asset).safeDecreaseAllowance(address(i_uniswapRouter), amountIn);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/SwapAutomator.sol)

### <a name="M-3"></a>[M-3] Direct `supportsInterface()` calls may cause caller to revert
Calling `supportsInterface()` on a contract that doesn't implement the ERC-165 standard will result in the call reverting. Even if the caller does support the function, the contract may be malicious and consume all of the transaction's available gas. Call it via a low-level [staticcall()](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f959d7e4e6ee0b022b41e5b644c79369869d8411/contracts/utils/introspection/ERC165Checker.sol#L119), with a fixed amount of gas, and check the return code, or use OpenZeppelin's [`ERC165Checker.supportsInterface()`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f959d7e4e6ee0b022b41e5b644c79369869d8411/contracts/utils/introspection/ERC165Checker.sol#L36-L39).

*Instances (3)*:
```solidity
File: ./src/FeeAggregator.sol

153:     return interfaceId == type(IFeeAggregator).interfaceId || PausableWithAccessControl.supportsInterface(interfaceId);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeAggregator.sol)

```solidity
File: ./src/FeeRouter.sol

181:     if (!IERC165(newFeeAggregator).supportsInterface(type(IFeeAggregator).interfaceId)) {

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/FeeRouter.sol)

```solidity
File: ./src/PausableWithAccessControl.sol

41:     return interfaceId == type(IAccessControlEnumerable).interfaceId || super.supportsInterface(interfaceId);

```
[Link to code](https://github.com/code-423n4/2024-12-chainlink/blob/main/./src/PausableWithAccessControl.sol)

