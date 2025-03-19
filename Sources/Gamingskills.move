module GamingSkins::NFTMarketplace {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::token;

    /// Struct representing a Gaming Skin (NFT).
    struct Skin has store, key {
        skin_id: u64,      // Unique identifier for the skin
        owner: address,    // Owner of the skin
        name: vector<u8>,  // Name of the skin
    }

    /// Function to create a new gaming skin (NFT).
    public fun create_skin(owner: &signer, skin_id: u64, name: vector<u8>) {
        let skin = Skin {
            skin_id,
            owner: signer::address_of(owner),
            name,
        };
        move_to(owner, skin);
    }

    /// Function to transfer a gaming skin (NFT) to another user.
    public fun transfer_skin(sender: &signer, recipient: address, skin_id: u64) acquires Skin {
        let skin = borrow_global_mut<Skin>(signer::address_of(sender));

        // Ensure the sender owns the skin
        assert!(skin.skin_id == skin_id, 1);

        // Transfer the skin to the recipient
        skin.owner = recipient;

        // Move the updated skin to the sender's account (to reflect the transfer)
        move_to(sender, skin);
    }
}
