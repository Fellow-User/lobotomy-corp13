/mob/living/simple_animal/hostile/abnormality/for_your_eyes_only
    name = "For Your Eyes Only"
	desc = "A Detective with an Eye for Detail."
	icon = 'ModularTegustation/Teguicons/64x96.dmi'
	icon_state = "Eyes"
	icon_living = "Eyes"
	icon_dead = "Eyes_Closed"
    del_on_death = FALSE
	var/is_phaseTwo = TRUE //While phase two is still alive the abno is altered



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
	//attack_action_types = list(/datum/action/innate/abnormality_attack/DeadEye, //Hand Cannon Shot
	//                           /datum/action/innate/abnormality_attack/OpenWindow) //Pistol Shot
	var/handCannon_cooldown
	var/handCannon_cooldown_time = 6 SECONDS
	var/handCannon_damage = 40

	var/pistol_cooldown
	var/pistol_cooldown_time = 3 SECONDS
	var/pistol_damage = 12
	var/can_act

	can_breach = TRUE
	can_buckle = FALSE
	vision_range = 14
	aggro_vision_range = 20
	deathmessage = "He shuts his eyes."

	//-----------WORK PORTION-------------
	threat_level = HE_LEVEL
	start_qliphoth = 3
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
		/datum/ego_datum/weapon/window,
		/datum/ego_datum/weapon/Classified,
		/datum/ego_datum/armor/window
		)
	gift_type =  /datum/ego_gifts/DeputyBadge
	gift_message = ""
	*/

	//---------Second Form----------------
	if (is_phaseTwo == TRUE && !IsContained()){
		icon = 'ModularTegustation/Teguicons/64x96.dmi'
		icon_state = "existenceNull"
	    icon_living = "existenceNull"
	    name = "Existence Without Meaning"
	    desc = "An eye can ascribe meaning to light itself, therefore its absence is a lack of such."
	    maxHealth = 500
	    health = 500

		damage_coeff = list(BRUTE = 1, RED_DAMAGE = 1.2, WHITE_DAMAGE = 1.4, BLACK_DAMAGE = 0.6, PALE_DAMAGE = 1.3)
		fear_level = WAW_LEVEL

		//Attacks
	    ranged = TRUE
		minimum_distance = 2
		retreat_distance = 1

		attack_action_types = list(/datum/action/innate/abnormality_attack/OpenWindow, //Hand Cannon Shot
	                           /datum/action/innate/abnormality_attack/DeadEye) //Pistol Shot
	    revive(full_heal = TRUE, admin_revive = FALSE)

	}


/datum/action/innate/abnormality_attack/OpenWindow
	name = "Puncture a new window into the world"
	icon_icon = 'icons/obj/wizard.dmi'
	button_icon_state = "magicmd"
	chosen_message = "<span class='colossus'>You will now open a window.</span>"
	chosen_attack_num = 1


/datum/action/innate/abnormality_attack/DeadEye
	name = "Open their eyes"
	icon_icon = 'icons/obj/wizard.dmi'
	button_icon_state = "magicmd"
	chosen_message = "<span class='colossus'>You will now open eyes.</span>"
	chosen_attack_num = 2

/mob/living/simple_animal/hostile/abnormality/for_your_eyes_only/AttackingTarget(atom/attacked_target)
	return OpenFire()

/mob/living/simple_animal/hostile/abnormality/funeral/OpenFire()
	if(!can_act)
		return
	if(client)
		switch(chosen_attack)
			if(1)
				DeadEye(target)
			if(2)
				OpenWindow(target)
		return
	if(pistol_cooldown_time <= world.time && prob(85))
		DeadEye(target)
	else if(handCannon_cooldown_time <= world.time && prob(50))
		OpenWindow(target)
	return

//Handcannon Attack
/mob/living/simple_animal/hostile/abnormality/funeral/proc/OpenWindow(atom/target)
	if(!isliving(target)||handCannon_cooldown_time > world.time)
		return
	var/mob/living/cooler_target = target
	if(cooler_target.stat == DEAD)
		return

	can_act = FALSE
	icon_state = "Eyes_Opened"
	visible_message("[cooler_target] feels <span class='danger'>[src]'s gaze!</span>")
	dir = get_cardinal_dir(src, target)
	SLEEP_CHECK_DEATH(1.5 SECONDS)
	//playsound(get_turf(src), 'sound/abnormalities/funeral/spiritgun.ogg', 75, 1, 3)
	can_act = TRUE
	handCannon_cooldown_time = world.time + handCannon_cooldown_time
	icon_state = icon_living

	var/line_of_sight = getline(get_turf(src), get_turf(target)) //better simulates a projectile attack
	for(var/turf/T in line_of_sight)
		if(DensityCheck(T))
			return
	cooler_target.apply_damage(handCannon_damage, BLACK_DAMAGE, null, cooler_target.run_armor_check(null, BLACK_DAMAGE), spread_damage = TRUE)
	visible_message("<span class='danger'>[cooler_target]'s window has been opened!</span>")


//Pistol Attack
/mob/living/simple_animal/hostile/abnormality/funeral/proc/DeadEye(atom/target)
	if(!isliving(target)||pistol_cooldown_time > world.time)
		return
	var/mob/living/cooler_target = target
	if(cooler_target.stat == DEAD)
		return

	can_act = FALSE
	dir = get_cardinal_dir(src, target)
	SLEEP_CHECK_DEATH(0.5 SECONDS)
	//playsound(get_turf(src), 'sound/abnormalities/funeral/spiritgun.ogg', 75, 1, 3)
	can_act = TRUE
	pistol_cooldown_time = world.time + pistol_cooldown_time

	var/line_of_sight = getline(get_turf(src), get_turf(target)) //better simulates a projectile attack
	for(var/turf/T in line_of_sight)
		if(DensityCheck(T))
			return
	cooler_target.apply_damage(pistol_damage, BLACK_DAMAGE, null, cooler_target.run_armor_check(null, BLACK_DAMAGE), spread_damage = TRUE)
	visible_message("<span class='danger'>[cooler_target] has been punctured</span>")


//He Walk
/mob/living/simple_animal/hostile/abnormality/funeral/Move()
	if(!can_act)
		return FALSE
	return ..()
