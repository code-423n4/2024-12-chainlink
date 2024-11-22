# ✨ So you want to run an audit

This `README.md` contains a set of checklists for our audit collaboration.

Your audit will use two repos: 
- **an _audit_ repo** (this one), which is used for scoping your audit and for providing information to wardens
- **a _findings_ repo**, where issues are submitted (shared with you after the audit) 

Ultimately, when we launch the audit, this repo will be made public and will contain the smart contracts to be reviewed and all the information needed for audit participants. The findings repo will be made public after the audit report is published and your team has mitigated the identified issues.

Some of the checklists in this doc are for **C4 (🐺)** and some of them are for **you as the audit sponsor (⭐️)**.

---

# Audit setup

## 🐺 C4: Set up repos
- [ ] Create a new private repo named `YYYY-MM-sponsorname` using this repo as a template.
- [ ] Rename this repo to reflect audit date (if applicable)
- [ ] Rename audit H1 below
- [ ] Update pot sizes
  - [ ] Remove the "Bot race findings opt out" section if there's no bot race.
- [ ] Fill in start and end times in audit bullets below
- [ ] Add link to submission form in audit details below
- [ ] Add the information from the scoping form to the "Scoping Details" section at the bottom of this readme.
- [ ] Add matching info to the Code4rena site
- [ ] Add sponsor to this private repo with 'maintain' level access.
- [ ] Send the sponsor contact the url for this repo to follow the instructions below and add contracts here. 
- [ ] Delete this checklist.

# Repo setup

## ⭐️ Sponsor: Add code to this repo

- [ ] Create a PR to this repo with the below changes:
- [ ] Confirm that this repo is a self-contained repository with working commands that will build (at least) all in-scope contracts, and commands that will run tests producing gas reports for the relevant contracts.
- [ ] Please have final versions of contracts and documentation added/updated in this repo **no less than 48 business hours prior to audit start time.**
- [ ] Be prepared for a 🚨code freeze🚨 for the duration of the audit — important because it establishes a level playing field. We want to ensure everyone's looking at the same code, no matter when they look during the audit. (Note: this includes your own repo, since a PR can leak alpha to our wardens!)

## ⭐️ Sponsor: Repo checklist

- [ ] Modify the [Overview](#overview) section of this `README.md` file. Describe how your code is supposed to work with links to any relevent documentation and any other criteria/details that the auditors should keep in mind when reviewing. (Here are two well-constructed examples: [Ajna Protocol](https://github.com/code-423n4/2023-05-ajna) and [Maia DAO Ecosystem](https://github.com/code-423n4/2023-05-maia))
- [ ] Review the Gas award pool amount, if applicable. This can be adjusted up or down, based on your preference - just flag it for Code4rena staff so we can update the pool totals across all comms channels.
- [ ] Optional: pre-record a high-level overview of your protocol (not just specific smart contract functions). This saves wardens a lot of time wading through documentation.
- [ ] [This checklist in Notion](https://code4rena.notion.site/Key-info-for-Code4rena-sponsors-f60764c4c4574bbf8e7a6dbd72cc49b4#0cafa01e6201462e9f78677a39e09746) provides some best practices for Code4rena audit repos.

## ⭐️ Sponsor: Final touches
- [ ] Review and confirm the pull request created by the Scout (technical reviewer) who was assigned to your contest. *Note: any files not listed as "in scope" will be considered out of scope for the purposes of judging, even if the file will be part of the deployed contracts.*
- [ ] Check that images and other files used in this README have been uploaded to the repo as a file and then linked in the README using absolute path (e.g. `https://github.com/code-423n4/yourrepo-url/filepath.png`)
- [ ] Ensure that *all* links and image/file paths in this README use absolute paths, not relative paths
- [ ] Check that all README information is in markdown format (HTML does not render on Code4rena.com)
- [ ] Delete this checklist and all text above the line below when you're ready.

---

# Chainlink audit details
- Total Prize Pool: $100000 in USDC
  - HM awards: $80390 in USDC
  - (remove this line if there is no Analysis pool) Analysis awards: XXX XXX USDC (Notion: Analysis pool)
  - QA awards: $3360 in USDC
  - (remove this line if there is no Bot race) Bot Race awards: XXX XXX USDC (Notion: Bot Race pool)
 
  - Judge awards: $9500 in USDC
  - Validator awards: XXX XXX USDC (Notion: Triage fee - final)
  - Scout awards: $750 in USDC
  - (this line can be removed if there is no mitigation) Mitigation Review: XXX XXX USDC (*Opportunity goes to top 3 backstage wardens based on placement in this audit who RSVP.*)
- [Read our guidelines for more details](https://docs.code4rena.com/roles/wardens)
- Starts December 6, 2024 20:00 UTC
- Ends January 3, 2025 20:00 UTC

## Automated Findings / Publicly Known Issues

The 4naly3er report can be found [here](https://github.com/code-423n4/2024-12-chainlink/blob/main/4naly3er-report.md).



_Note for C4 wardens: Anything included in this `Automated Findings / Publicly Known Issues` section is considered a publicly known issue and is ineligible for awards._
## 🐺 C4: Begin Gist paste here (and delete this line)





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

| File         |
| ------------ |
| ./src/vendor/@aave/core-v3/contracts/protocol/libraries/math/PercentageMath.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/automation/AutomationBase.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/mocks/MockLinkToken.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/shared/interfaces/IERC677Receiver.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/shared/interfaces/ITypeAndVersion.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol |
| ./src/vendor/@chainlink/contracts/src/v0.8/shared/token/ERC677/IERC677Receiver.sol |
| ./src/vendor/@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol |
| ./src/vendor/@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IAny2EVMMessageReceiver.sol |
| ./src/vendor/@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol |
| ./src/vendor/@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/automation/ILinkAvailable.sol |
| ./src/vendor/@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol |
| ./src/vendor/@uniswap/swap-router-contracts/contracts/interfaces/IV3SwapRouter.sol |
| ./src/vendor/@uniswap/v3-core/contracts/interfaces/callback/IUniswapV3SwapCallback.sol |
| ./src/vendor/@uniswap/v3-periphery/contracts/interfaces/IQuoterV2.sol |
| ./test/Addresses.t.sol |
| ./test/BaseTest.t.sol |
| ./test/Constants.t.sol |
| ./test/fork/BaseForkTest.t.sol |
| ./test/fork/fee-aggregator/bridge-assets/bridgeAssets.t.sol |
| ./test/fork/fee-aggregator/ccip-receive/ccipReceive.t.sol |
| ./test/fork/swap-automator/perform-upkeep/performUpkeep.t.sol |
| ./test/integration/BaseIntegrationTest.t.sol |
| ./test/integration/fee-aggregator/emergency-withdraw/emergencyWithdraw.t.sol |
| ./test/integration/fee-aggregator/transfer-for-swap/transferForSwap.t.sol |
| ./test/integration/fee-aggregator/withdraw-non-allowlisted-assets/withdrawNonAllowlistedAssets.t.sol |
| ./test/integration/fee-router/transfer-allowlisted-assets/transferAllowlistedAssets.t.sol |
| ./test/integration/fee-router/withdraw-non-allowlisted-assets/withdrawNonAllowlistedAssets.t.sol |
| ./test/integration/reserves/emergency-withdraw/emergencyWithdraw.t.sol |
| ./test/invariants/BaseInvariant.t.sol |
| ./test/invariants/Reserves.invariants.t.sol |
| ./test/invariants/SwapAutomator.invariants.t.sol |
| ./test/invariants/handlers/AssetHandler.t.sol |
| ./test/invariants/handlers/ReservesHandler.t.sol |
| ./test/invariants/handlers/UpkeepHandler.t.sol |
| ./test/invariants/mocks/MockAggregatorV3.t.sol |
| ./test/invariants/mocks/MockUniswapQuoterV2.t.sol |
| ./test/invariants/mocks/MockUniswapRouter.t.sol |
| ./test/unit/BaseUnitTest.t.sol |
| ./test/unit/enumerable-bytes-set/add/add.t.sol |
| ./test/unit/enumerable-bytes-set/remove/remove.t.sol |
| ./test/unit/fee-aggregator/apply-allowlisted-assets/addAllowlistedAssets.t.sol |
| ./test/unit/fee-aggregator/apply-allowlisted-assets/removeAllowlistedAssets.t.sol |
| ./test/unit/fee-aggregator/apply-allowlisted-receivers/addAllowlistedReceivers.t.sol |
| ./test/unit/fee-aggregator/apply-allowlisted-receivers/removeAllowlistedReceivers.t.sol |
| ./test/unit/fee-aggregator/apply-allowlisted-senders/addAllowlistedSenders.t.sol |
| ./test/unit/fee-aggregator/apply-allowlisted-senders/removeAllowlistedSenders.t.sol |
| ./test/unit/fee-aggregator/ccip-receive/ccipReceive.t.sol |
| ./test/unit/fee-aggregator/constructor/constructor.t.sol |
| ./test/unit/fee-aggregator/supports-interface/supportsInterface.t.sol |
| ./test/unit/fee-router/constructor/constructor.t.sol |
| ./test/unit/fee-router/set-fee-aggregator/setFeeAggregator.t.sol |
| ./test/unit/pausable-with-access-control/emergency-pause/emergencyPause.t.sol |
| ./test/unit/pausable-with-access-control/emergency-unpause/emergencyUnpause.t.sol |
| ./test/unit/pausable-with-access-control/grant-role/grantRole.t.sol |
| ./test/unit/pausable-with-access-control/revoke-role/revokeRole.t.sol |
| ./test/unit/pausable-with-access-control/supports-interface/supportsInterface.t.sol |
| ./test/unit/reserves/add-allowlisted-service-providers/addAllowlistedServiceProviders.t.sol |
| ./test/unit/reserves/constructor/constructor.t.sol |
| ./test/unit/reserves/on-token-transfer/onTokenTransfer.t.sol |
| ./test/unit/reserves/remove-allowlisted-service-providers/removeAllowlistedServiceProviders.t.sol |
| ./test/unit/reserves/set-earmarks/setEarmarks.t.sol |
| ./test/unit/reserves/withdraw/withdraw.t.sol |
| ./test/unit/swap-automator/apply-asset-swap-params-updates/applyAssetSwapParamsUpdates.t.sol |
| ./test/unit/swap-automator/check-upkeep/checkUpkeep.t.sol |
| ./test/unit/swap-automator/constructor/constructor.t.sol |
| ./test/unit/swap-automator/set-deadline-delay/setDeadlineDelay.t.sol |
| ./test/unit/swap-automator/set-fee-aggregator-receiver/setFeeAggregatorReceiver.sol |
| ./test/unit/swap-automator/set-forwarder/setForwarder.t.sol |
| ./test/unit/swap-automator/set-receiver/setReceiver.t.sol |
| Totals: 73 |

