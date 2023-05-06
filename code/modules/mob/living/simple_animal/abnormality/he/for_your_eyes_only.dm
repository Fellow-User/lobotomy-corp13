/mob/living/simple_animal/hostile/abnormality/for_your_eyes_only
    name = "For Your Eyes Only"
	desc = "A Detective with an Eye for Detail."
	icon = 'ModularTegustation/Teguicons/64x96.dmi'
	icon_state = "Eyes"
	icon_living = "Eyes"
	icon_dead = "Eyes_Closed"
    del_on_death = FALSE


	//Largely gonna use Funeral's Code
	//-----------STATS PORTION------------- (REAL FORM)
	ranged = TRUE
	minimum_distance = 2
	retreat_distance = 1

    maxHealth = 800
	health = 800
    move_to_delay = 4
	damage_coeff = list(BRUTE = 2, RED_DAMAGE = 2, WHITE_DAMAGE = 2, BLACK_DAMAGE = 2, PALE_DAMAGE = 2) .
	stat_attack = HARD_CRIT
	attack_action_types = list(/datum/action/innate/abnormality_attack/DeadEye, //Hand Cannon Shot
	                           /datum/action/innate/abnormality_attack/OpenWindow) //Pistol Shot

	can_breach = TRUE
	can_buckle = FALSE
	vision_range = 14
	aggro_vision_range = 20
	deathmessage = "He shuts his eyes."

	//-----------WORK PORTION-------------
	threat_level = HE_LEVEL
	start_qliphoth = 5
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = 60,
		ABNORMALITY_WORK_INSIGHT = (30, 50, 65, 75, 85),
		ABNORMALITY_WORK_ATTACHMENT = 35,
		ABNORMALITY_WORK_REPRESSION = 10,
		)
	work_damage_amount = 10
	work_damage_type = WHITE_DAMAGE
	max_boxes = 18

    //-----------EGO LIST----------------- (Dump not ready yet)
	/*
    ego_list = list(
		/datum/ego_datum/weapon/Window_To_The_World,
		/datum/ego_datum/weapon/Classified,
		/datum/ego_datum/armor/Window_To_The_World
		)
	gift_type =  /datum/ego_gifts/DeputyBadge
	gift_message = ""
	*/

	//---------Second Form----------------
	is_phaseTwo = TRUE //While phase two is still alive the abno is altered
	if (is_phaseTwo == TRUE){
		icon = 'ModularTegustation/Teguicons/64x96.dmi'
		icon_state = "existenceNull"
	    icon_living = "existenceNull"
	    name = "Existence Without Meaning"
	    desc = "An eye can ascribe meaning to light itself, therefore its absence is a lack of such."
	    maxHealth = 500
	    health = 500

		damage_coeff = list(BRUTE = 0.6, RED_DAMAGE = 1.2, WHITE_DAMAGE = 1.4, BLACK_DAMAGE = 0.6, PALE_DAMAGE = 1.3)
		fear_level = WAW_LEVEL

		//Attacks
	    ranged = TRUE
		minimum_distance = 2
		retreat_distance = 1

		attack_action_types = list(/datum/action/innate/abnormality_attack/DeadEye, //Hand Cannon Shot
	                           /datum/action/innate/abnormality_attack/OpenWindow) //Pistol Shot


	}
