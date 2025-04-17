import credits.aleo;
// The 'piggybanker' program.
program piggybanker.aleo {
    const ADMIN: address = aleo1f6hhrs823257c4p8efy26cwp4fwga4wjl2s0383e52ngw3xhnq9q2dlwl7;
    const TAX: u16 = 93u16;
    record Token {
        owner: address,
        amount: u64
    }
    record Vault {
        owner: address,
        vaultopen: u64
    }
    
    mapping balance: address => u64;

    async transition deposit(public receiver: address, public amount: u64) -> Future {
        return finalize_deposit(self.caller, self.address, amount);
    }

    async function finalize_deposit(sender: address, receiver: address, amount: u64){
        let pertax: u64 = TAX as u64;
        let tax_amount: u64 = amount*pertax/10000u64;
        let taxed_amount: u64 = amount - tax_amount;
        let admin_old_balance: u64 = balance.get_or_use(ADMIN, 0u64);
        let admin_new_balance: u64 = admin_old_balance + tax_amount;
        balance.set(ADMIN, admin_new_balance);

        let vault_old_balance: u64 = balance.get_or_use(self.address, 0u64);
        let vault_new_balance: u64 = vault_old_balance + taxed_amount;
        balance.set(self.address, vault_new_balance);
        
        let sender_old_balance: u64 = balance.get_or_use(sender, 0u64);
        let sender_new_balance: u64 = sender_old_balance - amount;
        balance.set(sender, sender_new_balance);
    }
    async transition withdraw(public receiver: address, public amount: u64) -> Future {
        return finalize_withdraw(self.caller, receiver, amount);
    }
    async function finalize_withdraw(sender: address, receiver: address, amount: u64){
        let vault_old_balance: u64 = balance.get_or_use(self.address, 0u64);
        let vault_new_balance: u64 = vault_old_balance - amount;
        balance.set(self.address, vault_new_balance);

        let receiver_old_balance: u64 = balance.get_or_use(receiver, 0u64);
        let receiver_new_balance: u64 = receiver_old_balance + amount;
        balance.set(receiver, receiver_new_balance);
    }

    


}