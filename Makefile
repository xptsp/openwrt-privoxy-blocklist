include $(TOPDIR)/rules.mk

PKG_NAME:=privoxy-blocklist
PKG_VERSION:=0.4.0
PKG_RELEASE:=1
PKG_LICENSE:=unlicense

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Andrwe/privoxy-blocklist.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_MIRROR_HASH:=7ea4b3df6c5728d7381dacff37fa46c7f6f7469716c821550b058cec3fa67ad7

include $(INCLUDE_DIR)/package.mk

define Package/privoxy-blocklist
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Privoxy Blocklist Script
	DEPENDS:=+bash +grep +privoxy +sed +wget-ssl
	PKGARCH:=all
endef

define Package/privoxy-blocklist/description
 The script privoxy-blocklist.sh downloads AdBlock Plus filter files and generates privoxy
 compatible filter and action files based on these. After the generation is done it modifies 
 the privoxy configuration files /etc/privoxy/config to import the generated files.

 Due to this behaviour the script must run as root user to be able to modify the privoxy configuration file.
endef

define Package/privoxy-blocklist/conffiles
/etc/config/privoxy-blocklist
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/privoxy-blocklist/install
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/privoxy-blocklist $(1)/etc/config/privoxy-blocklist

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/privoxy-blocklist.sh $(1)/usr/bin/
endef

$(eval $(call BuildPackage,privoxy-blocklist))
