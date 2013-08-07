BUILD_DIR=.

JCE_PROVIDER_BC_STATUS=JCEProviderBouncyCastleStatus
JCE_UNLIMITED_STRENGTH_STATUS=JCEUnlimitedStrengthStatus
JCE_PROVIDER_BC_CP="bcprov-jdk15on-149.jar:"
#JCE_PROVIDER_BC_SECURITY_PROPERTIES=java.security.jdk1.7.0.25.x86_64
JCE_PROVIDER_BC_SECURITY_PROPERTIES=java.security.jdk1.6.0_45-x64
JCE_PROVIDER_BC_OPTION=-Djava.security.properties=$JCE_PROVIDER_BC_SECURITY_PROPERTIES

#--------------------support function to find out if Bouncy Castle JCE Provider is registered---------------------------
find_status_JCE_provider_Bouncy_Castle() {
	echo Find Bouncy Castle JCE Provider status
	cat <<EOF > $BUILD_DIR/$JCE_PROVIDER_BC_STATUS.java
public class $JCE_PROVIDER_BC_STATUS {
	public static void main(String [] args) {
		  if (java.security.Security.getProvider("BC") == null)
		    System.err.println("Bouncy Castle JCE Provider is not registred");
		  else
		    System.err.println("Bouncy Castle JCE Provider is already registered");
	}
}
EOF
	javac $BUILD_DIR/$JCE_PROVIDER_BC_STATUS.java
	java -cp $JCE_PROVIDER_BC_CP$BUILD_DIR $JCE_PROVIDER_BC_OPTION $JCE_PROVIDER_BC_STATUS
}
#END OF--------------------support function to find out if Bouncy Castle JCE Provider is registered---------------------------

#--------------------support function to find out if JCE unlimited strength cryptography---------------------------
find_status_JCE_unlimited_strength() {
	echo Find JCE unlimited strength
	cat <<EOF > $BUILD_DIR/$JCE_UNLIMITED_STRENGTH_STATUS.java
public class $JCE_UNLIMITED_STRENGTH_STATUS {
	public static void main(String [] args) throws Exception {
		  if (javax.crypto.Cipher.getMaxAllowedKeyLength("RC5") < 256)
		    System.err.println("JCE limited strength cryptography");
		  else
		    System.err.println("JCE unlimited strength cryptography");
	}
}
EOF
	javac $BUILD_DIR/$JCE_UNLIMITED_STRENGTH_STATUS.java
	java -cp $BUILD_DIR $JCE_UNLIMITED_STRENGTH_STATUS
}
#END OF --------------------support function to find out if JCE unlimited strength cryptography---------------------------


java -version
find_status_JCE_unlimited_strength
find_status_JCE_provider_Bouncy_Castle

