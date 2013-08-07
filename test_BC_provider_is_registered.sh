BUILD_DIR=.

JCE_PROVIDER_BC_STATUS=JCEProviderBouncyCastleStatus

#--------------------support function to find out if Bouncy Castle JCE Provider is registered---------------------------
find_status_JCE_provider_Bouncy_Castle() {
	echo Find Bouncy Castle JCE Provider status
	cat <<EOF > $BUILD_DIR/$JCE_PROVIDER_BC_STATUS.java
public class $JCE_PROVIDER_BC_STATUS {
	public static void main(String [] args) {
		  if (java.security.Security.getProvider("BC") == null) {
		    System.err.println("Bouncy Castle JCE Provider is not registred");
				System.exit(1);
		  } else
		    System.err.println("Bouncy Castle JCE Provider is already registered");
	}
}
EOF
	javac $BUILD_DIR/$JCE_PROVIDER_BC_STATUS.java
	java -cp $JCE_PROVIDER_BC_CP$BUILD_DIR $JCE_PROVIDER_BC_OPTION $JCE_PROVIDER_BC_STATUS
	return $?
}
#END OF--------------------support function to find out if Bouncy Castle JCE Provider is registered---------------------------

java -version
find_status_JCE_provider_Bouncy_Castle
exit $?
