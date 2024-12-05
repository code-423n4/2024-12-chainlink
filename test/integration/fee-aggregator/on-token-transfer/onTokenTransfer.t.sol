// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.24;

import {FeeAggregator} from "src/FeeAggregator.sol";
import {LinkReceiver} from "src/LinkReceiver.sol";
import {Errors} from "src/libraries/Errors.sol";
import {BaseIntegrationTest} from "test/integration/BaseIntegrationTest.t.sol";

contract FeeAggregator_OnTokenTransferUnitTest is BaseIntegrationTest {
  function test_onTokenTransfer_RevertWhen_TheSenderIsNotTheLINKToken() external {
    vm.expectRevert(LinkReceiver.SenderNotLinkToken.selector);
    s_feeAggregatorReceiver.onTokenTransfer(address(0), 0, "");
  }

  function test_onTokenTransfer_ShouldTransferTheTokens() external {
    uint256 linkAmount = 100;
    uint256 balanceBefore = s_mockLINK.balanceOf(address(s_feeAggregatorReceiver));
    s_mockLINK.transferAndCall(address(s_feeAggregatorReceiver), linkAmount, "");
    uint256 balanceAfter = s_mockLINK.balanceOf(address(s_feeAggregatorReceiver));
    assertEq(balanceAfter, balanceBefore + linkAmount);
  }
}