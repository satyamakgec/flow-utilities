import FungibleToken from "./interfaces/FungibleToken.cdc"

pub contract Utilities {

    pub fun transfer(fromAccount: AuthAccount, toAccount: Address, fromPath: StoragePath, toPath: PublicPath) {
        // Get a reference to the signer's stored vault
        let vaultRef = fromAccount.borrow<&FungibleToken.Vault>(from: fromPath)
			?? panic("Could not borrow reference to the fromAccount's Vault!")

        // Get the recipient's public account object
        let recipient = getAccount(toAccount)

        // Get a reference to the recipient's Receiver
        let receiverRef = recipient.getCapability(toPath)
            .borrow<&{FungibleToken.Receiver}>()
			?? panic("Could not borrow receiver reference to the recipient's Vault")

        // Deposit the withdrawn tokens in the recipient's receiver
        receiverRef.deposit(from: <- vaultRef.withdraw(amount: amount))
    }

    pub fun borrowWithPanic(account): {

    }

}