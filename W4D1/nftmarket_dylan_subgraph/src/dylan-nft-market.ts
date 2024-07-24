import {
  Cancel as CancelEvent,
  EIP712DomainChanged as EIP712DomainChangedEvent,
  FeeToChanged as FeeToChangedEvent,
  Listed as ListedEvent,
  OwnershipTransferred as OwnershipTransferredEvent,
  Purchased as PurchasedEvent,
  WLSignerChanged as WLSignerChangedEvent
} from "../generated/Dylan_NFTMarket/Dylan_NFTMarket"
import {
  Cancel,
  EIP712DomainChanged,
  FeeToChanged,
  Listed,
  OwnershipTransferred,
  Purchased,
  WLSignerChanged
} from "../generated/schema"

export function handleCancel(event: CancelEvent): void {
  let entity = new Cancel(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.orderHashId = event.params.orderHashId

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handleEIP712DomainChanged(
  event: EIP712DomainChangedEvent
): void {
  let entity = new EIP712DomainChanged(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handleFeeToChanged(event: FeeToChangedEvent): void {
  let entity = new FeeToChanged(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.feeTo = event.params.feeTo

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handleListed(event: ListedEvent): void {
  let entity = new Listed(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.nft = event.params.nft
  entity.tokenId = event.params.tokenId
  entity.orderHashId = event.params.orderHashId
  entity.seller = event.params.seller
  entity.payToken = event.params.payToken
  entity.price = event.params.price
  entity.deadline = event.params.deadline
  entity.needWLSign = event.params.needWLSign

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handleOwnershipTransferred(
  event: OwnershipTransferredEvent
): void {
  let entity = new OwnershipTransferred(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.previousOwner = event.params.previousOwner
  entity.newOwner = event.params.newOwner

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handlePurchased(event: PurchasedEvent): void {
  let entity = new Purchased(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.tokenId = event.params.tokenId
  entity.seller = event.params.seller
  entity.buyer = event.params.buyer
  entity.price = event.params.price

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}

export function handleWLSignerChanged(event: WLSignerChangedEvent): void {
  let entity = new WLSignerChanged(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.nftContract = event.params.nftContract
  entity.WLSigner = event.params.WLSigner

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
