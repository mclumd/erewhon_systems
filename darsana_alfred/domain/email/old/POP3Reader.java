/** Save in file POP3Reader.java (case sensitive)  **/

/**
 * Interface used for the POP3Client to communicate with
 * the parent.
 */
public interface POP3Reader
{
	/**
	 * Called by POP3Client to pass error, diagnostic strings etc.
	 */
	public void info(String str);

	/**
	 * Called by POP3Client to pass mail data
	 */
	public void data(String str) throws java.io.IOException ;
}
