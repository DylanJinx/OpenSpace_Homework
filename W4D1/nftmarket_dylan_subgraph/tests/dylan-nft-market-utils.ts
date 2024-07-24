import { newMockEvent } from "matchstick-as"
import { ethereum, Bytes, Address, BigInt } from "@graphprotocol/graph-ts"
import {
  Cancel,
  EIP712DomainChanged,
  FeeToChanged,
  Listed,
  OwnershipTransferred,
  Purchased,
  WLSignerChanged
} from "../generated/Dylan_NFTMarket/Dylan_NFTMarket"

export function createCancelEvent(orderHashId: Bytes): Cancel {
  let cancelEvent = changetype<Cancel>(newMockEvent())

  cancelEvent.parameters = new Array()

  cancelEvent.parameters.push(
    new ethereum.EventParam(
      "orderHashId",
      ethereum.Value.fromFixedBytes(orderHashId)
    )
  )

  return cancelEvent
}

export function createEIP712DomainChangedEvent(): EIP712DomainChanged {
  let eip712DomainChangedEvent = changetype<EIP712DomainChanged>(newMockEvent())

  eip712DomainChangedEvent.parameters = new Array()

  return eip712DomainChangedEvent
}

export function createFeeToChangedEvent(feeTo: Address): FeeToChanged {
  let feeToChangedEvent = changetype<FeeToChanged>(newMockEvent())

  feeToChangedEvent.parameters = new Array()

  feeToChangedEvent.parameters.push(
    new ethereum.EventParam("feeTo", ethereum.Value.fromAddress(feeTo))
  )

  return feeToChangedEvent
}

export function createListedEvent(
  nft: Address,
  tokenId: BigInt,
  orderHashId: Bytes,
  seller: Address,
  payToken: Address,
  price: BigInt,
  deadline: BigInt,
  needWLSign: boolean
): Listed {
  let listedEvent = changetype<Listed>(newMockEvent())

  listedEvent.parameters = new Array()

  listedEvent.parameters.push(
    new ethereum.EventParam("nft", ethereum.Value.fromAddress(nft))
  )
  listedEvent.parameters.push(
    new ethereum.EventParam(
      "tokenId",
      ethereum.Value.fromUnsignedBigInt(tokenId)
    )
  )
  listedEvent.parameters.push(
    new ethereum.EventParam(
      "orderHashId",
      ethereum.Value.fromFixedBytes(orderHashId)
    )
  )
  listedEvent.parameters.push(
    new ethereum.EventParam("seller", ethereum.Value.fromAddress(seller))
  )
  listedEvent.parameters.push(
    new ethereum.EventParam("payToken", ethereum.Value.fromAddress(payToken))
  )
  listedEvent.parameters.push(
    new ethereum.EventParam("price", ethereum.Value.fromUnsignedBigInt(price))
  )
  listedEvent.parameters.push(
    new ethereum.EventParam(
      "deadline",
      ethereum.Value.fromUnsignedBigInt(deadline)
    )
  )
  listedEvent.parameters.push(
    new ethereum.EventParam(
      "needWLSign",
      ethereum.Value.fromBoolean(needWLSign)
    )
  )

  return listedEvent
}

export function createOwnershipTransferredEvent(
  previousOwner: Address,
  newOwner: Address
): OwnershipTransferred {
  let ownershipTransferredEvent = changetype<OwnershipTransferred>(
    newMockEvent()
  )

  ownershipTransferredEvent.parameters = new Array()

  ownershipTransferredEvent.parameters.push(
    new ethereum.EventParam(
      "previousOwner",
      ethereum.Value.fromAddress(previousOwner)
    )
  )
  ownershipTransferredEvent.parameters.push(
    new ethereum.EventParam("newOwner", ethereum.Value.fromAddress(newOwner))
  )

  return ownershipTransferredEvent
}

export function createPurchasedEvent(
  tokenId: BigInt,
  seller: Address,
  buyer: Address,
  price: BigInt
): Purchased {
  let purchasedEvent = changetype<Purchased>(newMockEvent())

  purchasedEvent.parameters = new Array()

  purchasedEvent.parameters.push(
    new ethereum.EventParam(
      "tokenId",
      ethereum.Value.fromUnsignedBigInt(tokenId)
    )
  )
  purchasedEvent.parameters.push(
    new ethereum.EventParam("seller", ethereum.Value.fromAddress(seller))
  )
  purchasedEvent.parameters.push(
    new ethereum.EventParam("buyer", ethereum.Value.fromAddress(buyer))
  )
  purchasedEvent.parameters.push(
    new ethereum.EventParam("price", ethereum.Value.fromUnsignedBigInt(price))
  )

  return purchasedEvent
}

export function createWLSignerChangedEvent(
  nftContract: Address,
  WLSigner: Address
): WLSignerChanged {
  let wlSignerChangedEvent = changetype<WLSignerChanged>(newMockEvent())

  wlSignerChangedEvent.parameters = new Array()

  wlSignerChangedEvent.parameters.push(
    new ethereum.EventParam(
      "nftContract",
      ethereum.Value.fromAddress(nftContract)
    )
  )
  wlSignerChangedEvent.parameters.push(
    new ethereum.EventParam("WLSigner", ethereum.Value.fromAddress(WLSigner))
  )

  return wlSignerChangedEvent
}
