BUILD_DIR=.

JCE_UNLIMITED_STRENGTH_STATUS=JCEUnlimitedStrengthStatus

#--------------------support function to find out if JCE unlimited strength cryptography---------------------------
find_status_JCE_unlimited_strength() {
	echo Find JCE unlimited strength
	cat <<EOF > $BUILD_DIR/$JCE_UNLIMITED_STRENGTH_STATUS.java
public class $JCE_UNLIMITED_STRENGTH_STATUS {
	public static void main(String [] args) throws Exception {
		  if (javax.crypto.Cipher.getMaxAllowedKeyLength("RC5") < 256) {
		    System.err.println("JCE limited strength cryptography");
				System.exit(1);
			} else
		    System.err.println("JCE unlimited strength cryptography");
	}
}
EOF
	javac $BUILD_DIR/$JCE_UNLIMITED_STRENGTH_STATUS.java
	java -cp $BUILD_DIR $JCE_UNLIMITED_STRENGTH_STATUS
	return $?
}
#END OF --------------------support function to find out if JCE unlimited strength cryptography---------------------------


java -version
find_status_JCE_unlimited_strength
exit $?
