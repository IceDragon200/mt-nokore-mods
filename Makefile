RELEASE_DIR=${TMP_DIR}/nokore

.PHONY : luacheck
luacheck:
	luacheck .

# Release step specifically when the modpack is under a game, this will copy
# the modpack to the TMP_DIR
.PHONY: prepare.release
prepare.release:
	mkdir -p "${RELEASE_DIR}"

	cp -r --parents nokore_apple "${RELEASE_DIR}"
	cp -r --parents nokore_backpacks "${RELEASE_DIR}"
	cp -r --parents nokore_bed "${RELEASE_DIR}"
	cp -r --parents nokore_book "${RELEASE_DIR}"
	cp -r --parents nokore_bookshelf "${RELEASE_DIR}"
	cp -r --parents nokore_chest "${RELEASE_DIR}"
	cp -r --parents nokore_door "${RELEASE_DIR}"
	cp -r --parents nokore_dye "${RELEASE_DIR}"
	cp -r --parents nokore_furnace "${RELEASE_DIR}"
	cp -r --parents nokore_glass "${RELEASE_DIR}"
	cp -r --parents nokore_gunpowder "${RELEASE_DIR}"
	cp -r --parents nokore_rail "${RELEASE_DIR}"
	cp -r --parents nokore_sieve "${RELEASE_DIR}"
	cp -r --parents nokore_stockpile "${RELEASE_DIR}"
	cp -r --parents nokore_tnt "${RELEASE_DIR}"
	cp -r --parents nokore_tool "${RELEASE_DIR}"
	cp -r --parents nokore_tool_bronze "${RELEASE_DIR}"
	cp -r --parents nokore_tool_copper "${RELEASE_DIR}"
	cp -r --parents nokore_tool_iron "${RELEASE_DIR}"
	cp -r --parents nokore_tool_steel "${RELEASE_DIR}"
	cp -r --parents nokore_tool_stone "${RELEASE_DIR}"
	cp -r --parents nokore_wool "${RELEASE_DIR}"
	cp -r --parents nokore_wool_mat "${RELEASE_DIR}"

	cp LICENSE "${RELEASE_DIR}"
	cp modpack.conf "${RELEASE_DIR}"
	cp README.md "${RELEASE_DIR}"
