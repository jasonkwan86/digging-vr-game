class_name UnlockMerchant
extends Upgrade

@export var merchant_to_unlock: MerchantHandler

func buy_upgrade() -> void:
	merchant_to_unlock.set_visibility(true)
