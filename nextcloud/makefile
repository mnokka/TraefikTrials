# Author: mika.nokka1@gmail.com  Dec, 2020:
#
# usage: make all -> build(everytime) and run 
# usage: make log --> fetch every images docker logs
# usage: make -B --> force build everything 
#
# include host volumes defitions (used also in .yml file)
# contant logging: sudo docker logs 67692e6f94b7  --follow


include .env




export REDIS

STOPFLAG=./STOPME


MYVARIABLES_NAMES:=DIR_DB DIR_NEXTCLOUD DIR_REDIS FILE_ACMEFILE FILE_YMLFILE
REQUIRED_DIRS = $(DIR_DB) $(DIR_NEXTCLOUD) $(DIR_REDIS)
MYVARIABLES := $(foreach var,$(MYVARIABLES_NAMES),$($(var)))


default: all


.SILENT: volumes_checker
volumes_checker:
	echo Checking existence of .env defined volume directories. These must exists before building can proceed
	$(foreach var,$(REQUIRED_DIRS),if test -d $(var) ; then echo YES EXISTS: $(var); else echo ERROR NOT EXISTS: $(var) && ls > $(STOPFLAG);fi;)
	if test -f $(FILE_ACMEFILE) ; then echo YES AMCE EXISTS: $(FILE_ACMEFILE); else echo ERROR ACME NOT EXISTS: $(FILE_ACMEFILE) && ls >> $(STOPFLAG);fi
	if test -f $(STOPFLAG);then echo ERROR.Stopping.Create missing volumes directories && rm $(STOPFLAG) && python3 failer.py ;else echo No problmes, carry on building;fi


all: create_volumes volumes_checker create_networks redis 

.PHONY: test

test:
	@:
	$(foreach v,$(MYVARIABLES_NAMES), $(info $(v) == $($v)))
	
create_volumes:
	@./create_volumes.sh

create_networks:
	@if ! docker network inspect nextweb >/dev/null 2>&1; then \
		docker network create nextweb; \
		echo "Created Docker nextweb"; \
	else \
		echo "Docker nextweb exists , done nothing"; \
    fi
	
	@if ! docker network inspect extweb >/dev/null 2>&1; then \
		docker network create extweb; \
		echo "Created Docker extweb"; \
	else \
		echo "Docker extweb exists , done nothing"; \
    fi



db: $(YMLFILE) 
	$(call composeit,db)
	touch db

redis: $(YMLFILE) 
	$(call composeit,redis)
	touch redis

nextcloud: $(YMLFILE)
	$(call composeit,nextcloud)
	touch nextloud
	
reverse-proxy: $(YMLFILE)
	$(call composeit,reverse-proxy)
	touch reverse-proxy	


#paremeter=name of the image to be booted up
define startdocker
	@echo ===============================================================================================
	@echo SETTING UP DOCKERIMAGE: $(1)
	@echo 	
	sudo docker-compose -f $(YMLFILE) up -d $(1)
endef

define prints 
	@echo 'ENV VARIABLE: $(eval($(1))) == $($(1))'
	@echo #nothing
endef 



