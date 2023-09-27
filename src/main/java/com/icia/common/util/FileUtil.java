/**
 * <pre>
 * 프로젝트명 : common
 * 패키지명   : com.icia.common.util
 * 파일명     : FileUtil.java
 * 작성일     : 2020. 12. 29.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.common.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.nio.channels.FileChannel;
import java.nio.charset.Charset;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * <pre>
 * 패키지명   : com.icia.common.util
 * 파일명     : FileUtil.java
 * 작성일     : 2020. 12. 29.
 * 작성자     : daekk
 * 설명       : 파일 관련 유틸리티
 * </pre>
 */
public final class FileUtil
{
	private static final long FILE_COPY_BUFFER_SIZE = 31457280;

	public static final long KILOBYTES  = 1024;
	public static final long MEGABYTES  = KILOBYTES * KILOBYTES;
	public static final long GIGABYTES  = MEGABYTES * KILOBYTES;
	public static final long TERABYTES  = GIGABYTES * KILOBYTES;
	public static final long PETABYTES  = TERABYTES * KILOBYTES; 
	public static final long EXABYTES   = PETABYTES * KILOBYTES;
	
	private FileUtil() {}

	/**
	 * <pre>
	 * 메소드명    : getTempDir
	 * 설명        : 시스템 템프 디렉토리 경로를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @return String
	 */
	public static String getTempDir()
	{
		return System.getProperty("java.io.tmpdir");
	}

	/**
	 * <pre>
	 * 메소드명    : getUserHome
	 * 설명        : 사용자 홈 디렉토리 경로를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @return String
	 */
	public static String getUserHome()
	{
		return System.getProperty("user.home");
	}

	/**
	 * <pre>
	 * 메소드명    : getUserDir
	 * 설명        : 현재 디렉토리 경로를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @return String
	 */
	public static String getUserDir()
	{
		return System.getProperty("user.dir");
	}
	
	/**
	 * <pre>
	 * 메소드명   : getLineSeparator
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 개행 문자를 얻는다.
	 * </pre>
	 * @return String
	 */
	public static String getLineSeparator()
	{
		return System.getProperty("line.separator");
	}
	
	/**
	 * <pre>
	 * 메소드명   : getFileSeparator
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일 구분자를 얻는다.
	 * </pre>
	 * @return String
	 */
	public static String getFileSeparator()
	{
		return System.getProperty("file.separator");
	}

	/**
	 * <pre>
	 * 메소드명    : isFile
	 * 설명        : 파일 체크
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param path 파일경로
	 * @return boolean
	 */
	public static boolean isFile(String path)
	{
		if(path != null)
		{
			return isFile(new File(path));
		}
		else
		{
			return false;
		}
	}

	/**
	 * <pre>
	 * 메소드명    : isFile
	 * 설명        : 파일 체크
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param file 파일객체
	 * @return boolean
	 */
	public static boolean isFile(final File file)
	{
		if(file != null && file.exists())
		{
			return file.isFile();
		}
		else
		{
			return false;
		}
	}

	/**
	 * <pre>
	 * 메소드명    : isDircetory
	 * 설명        : 디렉토리 체크
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param path 디렉토리경로
	 * @return boolean
	 */
	public static boolean isDircetory(String path)
	{
		if(path != null)
		{
			return isDircetory(new File(path));
		}
		else
		{
			return false;
		}
	}

	/**
	 * <pre>
	 * 메소드명    : isDircetory
	 * 설명        : 디렉토리 체크
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 파일객체
	 * @return boolean
	 */
	public static boolean isDircetory(final File directory)
	{
		if(directory != null && directory.exists())
		{
			return directory.isDirectory();
		}
		else
		{
			return false;
		}
	}

	/**
	 * <pre>
	 * 메소드명    : createDirectorys
	 * 설명        : 디렉토리를 생성한다.(상위 경로도 생성)
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param path 디렉토리경로
	 * @return boolean
	 */
	public static boolean createDirectorys(final String path)
	{
		boolean bFlag = false;

		if(path == null || path.length() <= 0)
		{
			return bFlag;
		}
		else
		{
			return createDirectorys(new File(path));
		}
	}

	/**
	 * <pre>
	 * 메소드명    : createDirectorys
	 * 설명        : 디렉토리를 생성한다.(상위 경로도 생성)
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 파일객체
	 * @return boolean
	 */
	public static boolean createDirectorys(final File directory)
	{
		boolean bFlag = false;

		if(directory == null)
		{
			return bFlag;
		}
		else
		{
			try
			{
				if(!directory.isDirectory())
				{
					bFlag = directory.mkdirs();
				}
				else
				{
					bFlag = true;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}

		return bFlag;
	}

	/**
	 * <pre>
	 * 메소드명    : createDirectory
	 * 설명        : 디렉토리를 생성한다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param path 디렉토리경로
	 * @return boolean
	 */
	public static boolean createDirectory(final String path)
	{
		boolean bFlag = false;

		if(path == null || path.length() <= 0)
		{
			return bFlag;
		}
		else
		{
			return createDirectory(new File(path));
		}
	}

	/**
	 * <pre>
	 * 메소드명    : createDirectory
	 * 설명        : 디렉토리를 생성한다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 파일객체
	 * @return boolean
	 */
	public static boolean createDirectory(final File directory)
	{
		boolean bFlag = false;

		if(directory == null)
		{
			return bFlag;
		}
		else
		{
			try
			{
				if(!directory.isDirectory())
				{
					bFlag = directory.mkdir();
				}
				else
				{
					bFlag = true;
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}

		return bFlag;
	}
	
	/**
	 * <pre>
	 * 메소드명   : getCanonicalPath
	 * 작성일     : 2020. 12. 31.
	 * 작성자     : daekk
	 * 설명       : 파일 또는 디렉토리의 경로를 얻는다.
	 * </pre>
	 * @param file java.File
	 * @return String
	 */
	public static String getCanonicalPath(final File file)
	{
		if(file != null)
		{
			try
			{
				return file.getCanonicalPath();
			}
			catch (IOException e)
			{
				e.printStackTrace();
				return null;
			}
		}
		
		return null;
	}

	/**
	 * <pre>
	 * 메소드명   : write
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 바이트를 스트림에 출력한다.
	 * </pre>
	 * @param bytes byte[]
	 * @param out OutputStream
	 * @return boolean
	 */
	public static boolean write(byte[] bytes, OutputStream out)
	{
		if(bytes == null)
		{
			return false;
		}

		if(out == null)
		{
			return false;
		}

		try
		{
			out.write(bytes);
		}
		catch(IOException e)
		{
			e.printStackTrace();

			return false;
		}

		return true;
	}

	/**
	 * <pre>
	 * 메소드명   : write
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 스트림에 출력한다.
	 * </pre>
	 * @param in 문자열
	 * @param out OutputStream
	 * @return boolean
	 */
	public static boolean write(String in, OutputStream out)
	{
		return write(in, out, Charset.defaultCharset().name());
	}

	/**
	 * <pre>
	 * 메소드명   : write
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 스트림에 출력한다.
	 * </pre>
	 * @param in 문자열
	 * @param out OutputStream
	 * @param charset 캐릭터셋
	 * @return boolean
	 */
	public static boolean write(String in, OutputStream out, String charset)
	{
		boolean bFlag = false;

		if(in == null)
		{
			return bFlag;
		}

		if(out == null)
		{
			return bFlag;
		}

		if(charset == null)
		{
			return bFlag;
		}

		try
		{
			bFlag =  write(in.getBytes(charset), out);
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}

		return bFlag;
	}

	/**
	 * <pre>
	 * 메소드명   : write
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 입력 스트림을 출력 스트림에 출력한다.
	 * </pre>
	 * @param in InputStream
	 * @param out OutputStream
	 * @return int
	 */
	public static int write(InputStream in, OutputStream out)
	{
		int byteCount = 0;

		if(in == null)
		{
			return byteCount;
		}

		if(out == null)
		{
			return byteCount;
		}

		try
		{
			int bytesRead = -1;
			byte[] buffer = new byte[4096];

			while((bytesRead = in.read(buffer)) != -1)
			{
				out.write(buffer, 0, bytesRead);
				byteCount += bytesRead;
			}

			out.flush();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}

		return byteCount;
	}

	/**
	 * <pre>
	 * 메소드명    : copyFile
	 * 설명        : 파일 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 원본파일경로
	 * @param destFile 목적지파일경로
	 * @return boolean
	 */
	public static boolean copyFile(final String srcFile, final String destFile)
	{
		return copyFile(srcFile, destFile, true);
	}

	/**
	 * <pre>
	 * 메소드명    : copyFile
	 * 설명        : 파일 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 원본파일경로
	 * @param destFile 목적지파일경로
	 * @param lastModified 마지막수정일적용
	 * @return boolean
	 */
	public static boolean copyFile(final String srcFile, final String destFile, final boolean lastModified)
	{
		if(srcFile == null || srcFile.length() <= 0)
		{
			return false;
		}

		if(destFile == null || destFile.length() <= 0)
		{
			return false;
		}

		return copyFile(new File(srcFile), new File(destFile), lastModified);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : copyFile
	 * 설명        : 파일 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 원본파일객체
	 * @param destFile 목적지파일객체
	 * @return boolean
	 */
	public static boolean copyFile(final File srcFile, final File destFile)
	{
		return copyFile(srcFile, destFile, true);
	}

	/**
	 * <pre>
	 * 메소드명    : copyFile
	 * 설명        : 파일 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 원본파일객체
	 * @param destFile 목적지파일객체
	 * @param lastModified 마지막수정일적용
	 * @return boolean
	 */
	public static boolean copyFile(final File srcFile, final File destFile, final boolean lastModified)
	{
		try
		{
			if (srcFile == null)
			{
				return false;
			}

			if (destFile == null)
			{
				return false;
			}

			if (!srcFile.exists())
			{
				return false;
			}

			if(srcFile.isDirectory())
			{
				return false;
			}

			if(srcFile.getCanonicalPath().equals(destFile.getCanonicalPath()))
			{
				return false;
			}

			final File parentFile = destFile.getParentFile();

			if(parentFile != null)
			{
				if(!parentFile.mkdirs() && !parentFile.isDirectory())
				{
					return false;
				}
			}

			if(destFile.exists() && destFile.canWrite() == false)
			{
				return false;
			}

			doCopyFile(srcFile, destFile, lastModified);

			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return false;
	}

	private static void doCopyFile(final File srcFile, final File destFile, final boolean lastModified) throws IOException
	{
		if(destFile.exists() && destFile.isDirectory())
		{
			throw new IOException("destFile '" + destFile + "' exists but is a directory");
		}

		FileInputStream fis = null;
		FileOutputStream fos = null;
		FileChannel input = null;
		FileChannel output = null;

		try
		{
			fis = new FileInputStream(srcFile);
			fos = new FileOutputStream(destFile);
			input = fis.getChannel();
			output = fos.getChannel();
			final long size = input.size();
			long pos = 0;
			long count = 0;

			while(pos < size)
			{
				final long remain = size - pos;
				count = remain > FILE_COPY_BUFFER_SIZE ? FILE_COPY_BUFFER_SIZE : remain;
				final long bytesCopied = output.transferFrom(input, pos, count);

				if(bytesCopied == 0)
				{
					break;
				}

				pos += bytesCopied;
			}
		}
		finally
		{
			close(output, fos, input, fis);
		}

		final long srcLen = srcFile.length();
		final long dstLen = destFile.length();

		if(srcLen != dstLen)
		{
			throw new IOException("Failed to copy full contents from '" + srcFile + "' to '" + destFile + "' Expected length: " + srcLen + " Actual: " + dstLen + ".");
		}

		if(lastModified)
		{
			destFile.setLastModified(srcFile.lastModified());
		}
	}

	/**
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리경로
	 * @param destDir 목적지디렉토리경로
	 * @return boolean
	 */
	public static boolean copyDirectory(final String srcDir, final String destDir)
	{
		return copyDirectory(srcDir, destDir, null, true);
	}

	/**
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리경로
	 * @param destDir 목적지디렉토리경로
	 * @param lastModified 마지막수정일적용
	 * @return boolean
	 */
	public static boolean copyDirectory(final String srcDir, final String destDir, final boolean lastModified)
	{
		return copyDirectory(srcDir, destDir, null, lastModified);
	}

	/**
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리경로
	 * @param destDir 목적지디렉토리경로
	 * @param filter java.io.FileFilter
	 * @return boolean
	 */
	public static boolean copyDirectory(final String srcDir, final String destDir, final FileFilter filter)
	{
		return copyDirectory(srcDir, destDir, filter, true);
	}

	/**
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리경로
	 * @param destDir 목적지디렉토리경로
	 * @param filter java.io.FileFilter
	 * @param lastModified 마지막수정일적용
	 * @return boolean
	 */
	public static boolean copyDirectory(final String srcDir, final String destDir, final FileFilter filter, final boolean lastModified)
	{
		if (srcDir == null || srcDir.length() <= 0)
		{
			return false;
		}

		if (destDir == null || destDir.length() <= 0)
		{
			return false;
		}

		return copyDirectory(new File(srcDir), new File(destDir), filter, lastModified);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리객체
	 * @param destDir 목적지디렉토리객체
	 * @return boolean
	 */
	public static boolean copyDirectory(final File srcDir, final File destDir)
	{
		return copyDirectory(srcDir, destDir, null, true);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리객체
	 * @param destDir 목적지디렉토리객체
	 * @param lastModified 마지막수정일적용
	 * @return
	 */
	public static boolean copyDirectory(final File srcDir, final File destDir, final boolean lastModified)
	{
		return copyDirectory(srcDir, destDir, null, lastModified);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리객체
	 * @param destDir 목적지디렉토리객체
	 * @param filter java.io.FileFilter
	 * @return boolean
	 */
	public static boolean copyDirectory(final File srcDir, final File destDir, final FileFilter filter)
	{
		return copyDirectory(srcDir, destDir, filter, true);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : copyDirectory
	 * 설명        : 디렉토리 복사
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리객체
	 * @param destDir 목적지디렉토리객체
	 * @param filter java.io.FileFilter
	 * @param lastModified 마지막수정일적용
	 * @return boolean
	 */
	public static boolean copyDirectory(final File srcDir, final File destDir, final FileFilter filter, final boolean lastModified)
	{
		try
		{
			if (srcDir == null)
			{
				return false;
			}

			if (destDir == null)
			{
				return false;
			}

			if (!srcDir.exists())
			{
				return false;
			}

			if(!srcDir.isDirectory())
			{
				return false;
			}

			if(srcDir.getCanonicalPath().equals(destDir.getCanonicalPath()))
			{
				return false;
			}

			List<String> exclusionList = null;
			
			if(destDir.getCanonicalPath().startsWith(srcDir.getCanonicalPath()))
			{
				final File[] srcFiles = filter == null ? srcDir.listFiles() : srcDir.listFiles(filter);
				if(srcFiles != null && srcFiles.length > 0)
				{
					exclusionList = new ArrayList<String>(srcFiles.length);
					for(final File srcFile : srcFiles)
					{
						final File copiedFile = new File(destDir, srcFile.getName());
						exclusionList.add(copiedFile.getCanonicalPath());
					}
				}
			}

			doCopyDirectory(srcDir, destDir, filter, lastModified, exclusionList);

			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return false;
	}

	private static void doCopyDirectory(final File srcDir, final File destDir, final FileFilter filter, final boolean lastModified, final List<String> exclusionList) throws IOException
	{
		final File[] srcFiles = filter == null ? srcDir.listFiles() : srcDir.listFiles(filter);

		if(srcFiles == null)
		{
			throw new IOException("Failed to list contents of " + srcDir + ".");
		}

		if(destDir.exists())
		{
			if(destDir.isDirectory() == false)
			{
				throw new IOException("Destination '" + destDir + "' exists but is not a directory.");
			}
		}
		else
		{
			if(!destDir.mkdirs() && !destDir.isDirectory())
			{
				throw new IOException("Destination '" + destDir + "' directory cannot be created.");
			}
		}

		if(destDir.canWrite() == false)
		{
			throw new IOException("Destination '" + destDir + "' cannot be written to.");
		}

		for(final File srcFile : srcFiles)
		{
			final File dstFile = new File(destDir, srcFile.getName());

			if(exclusionList == null || !exclusionList.contains(srcFile.getCanonicalPath()))
			{
				if(srcFile.isDirectory())
				{
					doCopyDirectory(srcFile, dstFile, filter, lastModified, exclusionList);
				}
				else
				{
					doCopyFile(srcFile, dstFile, lastModified);
				}
			}
		}

		if(lastModified)
		{
			destDir.setLastModified(srcDir.lastModified());
		}
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : moveFile
	 * 설명        : 파일 이동
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 대상파일경로
	 * @param destFile 이동파일경로
	 * @return boolean
	 */
	public static boolean moveFile(final String srcFile, final String destFile)
	{
		if (srcFile == null || srcFile.length() <= 0)
		{
			return false;
		}

		if (destFile == null || destFile.length() <= 0)
		{
			return false;
		}

		return moveFile(new File(srcFile), new File(destFile));
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : moveFile
	 * 설명        : 파일 이동
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 대상파일객체
	 * @param destFile 이동파일객체
	 * @return boolean
	 */
	public static boolean moveFile(final File srcFile, final File destFile)
	{
		if (srcFile == null)
		{
			return false;
		}

		if (destFile == null)
		{
			return false;
		}

		try
		{
			doMoveFile(srcFile, destFile);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return false;
	}

	private static void doMoveFile(final File srcFile, final File destFile) throws IOException
	{
		if(srcFile == null)
		{
			throw new NullPointerException("srcFile is null");
		}

		if(destFile == null)
		{
			throw new NullPointerException("destFile mis null");
		}

		if(!srcFile.exists())
		{
			throw new FileNotFoundException("srcFile '" + srcFile + "' does not exist");
		}

		if(srcFile.isDirectory())
		{
			throw new IOException("srcFile '" + srcFile + "' is a directory");
		}

		if(destFile.exists())
		{
			throw new IOException("destFile '" + destFile + "' already exists");
		}

		if(destFile.isDirectory())
		{
			throw new IOException("destFile '" + destFile + "' is a directory");
		}

		final boolean rename = srcFile.renameTo(destFile);
		if(!rename)
		{
			if(copyFile(srcFile, destFile))
			{
				if(!srcFile.delete())
				{
					deleteFile(destFile);
					throw new IOException("Failed to delete original file '" + srcFile + "' after copy to '" + destFile + "'");
				}
			}
			else
			{
				throw new IOException("Failed to copy file '" + srcFile + "' to '" + destFile + "'");
			}
		}
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : moveDirectory
	 * 설명        : 디렉토리 이동
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리경로
	 * @param destDir 이동디렉토리경로
	 * @return boolean
	 */
	public static boolean moveDirectory(final String srcDir, final String destDir)
	{
		if(srcDir == null || srcDir.length() <= 0)
		{
			return false;
		}

		if(destDir == null || destDir.length() <= 0)
		{
			return false;
		}

		return moveDirectory(new File(srcDir), new File(destDir));
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : moveDirectory
	 * 설명        : 디렉토리 이동
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcDir 대상디렉토리객체
	 * @param destDir 이동디렉토리객체
	 * @return boolean
	 */
	public static boolean moveDirectory(final File srcDir, final File destDir)
	{
		if(srcDir == null)
		{
			return false;
		}

		if(destDir == null)
		{
			return false;
		}

		try
		{
			doMoveDirectory(srcDir, destDir);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return false;
	}

	private static void doMoveDirectory(final File srcDir, final File destDir) throws IOException
	{
		if(srcDir == null)
		{
			throw new NullPointerException("srcDir must not be null");
		}

		if(destDir == null)
		{
			throw new NullPointerException("destDir must not be null");
		}

		if(!srcDir.exists())
		{
			throw new FileNotFoundException("srcDir '" + srcDir + "' does not exist");
		}

		if(!srcDir.isDirectory())
		{
			throw new IOException("srcDir '" + srcDir + "' is not a directory");
		}

		if(destDir.exists())
		{
			throw new IOException("destDir '" + destDir + "' already exists");
		}

		final boolean rename = srcDir.renameTo(destDir);
		if(!rename)
		{
			if(destDir.getCanonicalPath().startsWith(srcDir.getCanonicalPath() + File.separator))
			{
				throw new IOException("Cannot move directory: " + srcDir + " to a subdirectory of itself: " + destDir);
			}

			if(copyDirectory(srcDir, destDir))
			{
				if(deleteDirectory(srcDir))
				{
					if(srcDir.exists())
					{
						throw new IOException("Failed to delete original directory '" + srcDir + "' after copy to '" + destDir + "'");
					}
				}
				else
				{
					throw new IOException("Failed to delete original directory '" + srcDir + "' after copy to '" + destDir + "'");
				}
			}
			else
			{
				throw new IOException("Failed to copy directory '" + srcDir + "' to '" + destDir + "'");
			}
		}
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : deleteFile
	 * 설명        : 파일 삭제
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 삭제파일경로
	 * @return boolean
	 */
	public static boolean deleteFile(final String srcFile)
	{
		if(srcFile == null || srcFile.length() <= 0)
		{
			return false;
		}

		return deleteFile(new File(srcFile));
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : deleteFile
	 * 설명        : 파일 삭제
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 삭제파일객체
	 * @return boolean
	 */
	public static boolean deleteFile(final File srcFile)
	{
		if(srcFile == null)
		{
			return false;
		}

		if(!srcFile.exists())
		{
			return false;
		}

		if(srcFile.isDirectory())
		{
			return false;
		}

		try
		{
			forceDelete(srcFile);
		}
		catch(Exception e)
		{
			e.printStackTrace();

			return false;
		}

		return true;
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : deleteDirectory
	 * 설명        : 디렉토리 삭제
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 디렉토리경로
	 * @return boolean
	 */
	public static boolean deleteDirectory(final String directory)
	{
		if(directory == null || directory.length() <= 0)
		{
			return false;
		}

		return deleteDirectory(new File(directory));
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : deleteDirectory
	 * 설명        : 디렉토리 삭제
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 디렉토리객체
	 * @return boolean
	 */
	public static boolean deleteDirectory(final File directory)
	{
		if(directory == null)
		{
			return false;
		}

		try
		{
			doDeleteDirectory(directory);

			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return false;
	}

	private static void doDeleteDirectory(final File directory) throws IOException
	{
		if (!directory.exists())
		{
			return;
		}

		if (!isSymlink(directory))
		{
			cleanDirectory(directory);
		}

		if (!directory.delete())
		{
			throw new IOException("Unable to delete directory " + directory + ".");
		}
	}

	private static void forceDelete(final File file) throws IOException
	{
		if(file.isDirectory())
		{
			doDeleteDirectory(file);
		}
		else
		{
			final boolean filePresent = file.exists();

			if(!file.delete())
			{
				if(!filePresent)
				{
					throw new FileNotFoundException("File does not exist: " + file + ".");
				}

				throw new IOException("Unable to delete file: " + file + ".");
			}
		}
	}

	private static void cleanDirectory(final File directory) throws IOException
	{
		final File[] files = verifiedListFiles(directory);

		IOException exception = null;
		for (final File file : files)
		{
			try
			{
				forceDelete(file);
			}
			catch (final IOException ioe)
			{
				exception = ioe;
			}
		}

		if (null != exception)
		{
			throw exception;
		}
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : listFiles
	 * 설명        : 디렉토리 파일 리스트를 얻는다. (디렉토리 포함)
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 디렉토리경로
	 * @return java.io.File[]
	 */
	public static File[] listFiles(final String directory)
	{
		if(directory == null || directory.length() <= 0)
		{
			return null;
		}

		return listFiles(new File(directory));
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : listFiles
	 * 설명        : 디렉토리 파일 리스트를 얻는다. (디렉토리 포함)
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param directory 디렉토리객체
	 * @return java.io.File[]
	 */
	public static File[] listFiles(final File directory)
	{
		if(directory == null)
		{
			return null;
		}

		File[] files = null;

		try
		{
			files = verifiedListFiles(directory);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return files;
	}

	private static File[] verifiedListFiles(File directory) throws IOException
	{
		if(!directory.exists())
		{
			throw new IllegalArgumentException(directory + " does not exist.");
		}

		if(!directory.isDirectory())
		{
			throw new IllegalArgumentException(directory + " is not a directory.");
		}

		final File[] files = directory.listFiles();

		if(files == null)
		{ // null if security restricted
			throw new IOException("Failed to list contents of " + directory + ".");
		}

		return files;
	}

	private static boolean isSymlink(final File file) throws IOException
	{
		if(file == null)
		{
			throw new NullPointerException("File must not be null");
		}

		if(File.separatorChar == '\\')
		{
			return false;
		}

		File fileInCanonicalDir = null;

		if(file.getParent() == null)
		{
			fileInCanonicalDir = file;
		}
		else
		{
			final File canonicalDir = file.getParentFile().getCanonicalFile();
			fileInCanonicalDir = new File(canonicalDir, file.getName());
		}

		if(fileInCanonicalDir.getCanonicalFile().equals(fileInCanonicalDir.getAbsoluteFile()))
		{
			return isBrokenSymlink(file);
		}
		else
		{
			return true;
		}
	}

	private static boolean isBrokenSymlink(final File file) throws IOException
	{
		if(file.exists())
		{
			return false;
		}

		final File canon = file.getCanonicalFile();
		File parentDir = canon.getParentFile();
		if(parentDir == null || !parentDir.exists())
		{
			return false;
		}

		File[] fileInDir = parentDir.listFiles(new FileFilter()
		{
			public boolean accept(File aFile)
			{
				return aFile.equals(canon);
			}
		});

		return fileInDir != null && fileInDir.length > 0;
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : openOutputStream
	 * 설명        : FileOutputStream 객체를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일경로
	 * @return java.io.FileOutputStream
	 */
	public static FileOutputStream openOutputStream(final String srcFile)
	{
		if(srcFile == null || srcFile.length() <= 0)
		{
			return null;
		}

		return openOutputStream(new File(srcFile), false);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : openOutputStream
	 * 설명        : FileOutputStream 객체를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일경로
	 * @param append 파일끝에붙여쓰기
	 * @return java.io.FileOutputStream
	 */
	public static FileOutputStream openOutputStream(final String srcFile, final boolean append)
	{
		if(srcFile == null || srcFile.length() <= 0)
		{
			return null;
		}

		return openOutputStream(new File(srcFile), append);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : openOutputStream
	 * 설명        : FileOutputStream 객체를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일객체
	 * @return java.io.FileOutputStream
	 */
	public static FileOutputStream openOutputStream(final File srcFile)
	{
		return openOutputStream(srcFile, false);
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : openOutputStream
	 * 설명        : FileOutputStream 객체를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일객체
	 * @param append 파일끝에붙이기
	 * @return java.io.FileOutputStream
	 */
	public static FileOutputStream openOutputStream(final File srcFile, final boolean append)
	{
		if(srcFile == null)
		{
			return null;
		}

		try
		{
			if(srcFile.exists())
			{
				if(srcFile.isDirectory())
				{
					return null;
				}
				if(srcFile.canWrite() == false)
				{
					return null;
				}
			}
			else
			{
				final File parent = srcFile.getParentFile();
				if(parent != null)
				{
					if(!parent.mkdirs() && !parent.isDirectory())
					{
						return null;
					}
				}
			}

			return new FileOutputStream(srcFile, append);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : openInputStream
	 * 설명        : FileInputStream 객체를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일경로
	 * @return java.io.FileInputStream
	 */
	public static FileInputStream openInputStream(final String srcFile)
	{
		if(srcFile == null || srcFile.length() <= 0)
		{
			return null;
		}

		return openInputStream(new File(srcFile));
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : openInputStream
	 * 설명        : FileInputStream 객체를 얻는다.
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일객체
	 * @return java.io.FileInputStream
	 */
	public static FileInputStream openInputStream(final File srcFile)
	{
		if(srcFile == null)
		{
			return null;
		}

		try
		{
			if (srcFile.exists())
			{
				if (srcFile.isDirectory())
				{
					return null;
				}

				if (srcFile.canRead() == false)
				{
					return null;
				}
			}
			else
			{
				return null;
			}

			return new FileInputStream(srcFile);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	 * <pre>
	 * 메소드명   : openInputStream
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : InputStream 객체를 얻는다.
	 * </pre>
	 * @param reader java.io.Reader
	 * @return java.io.InputStream
	 */
	public static InputStream openInputStream(final Reader reader)
	{
		return openInputStream(reader, null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : openInputStream
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : InputStream 객체를 얻는다.
	 * </pre>
	 * @param reader java.io.Reader
	 * @param charset 캐릭터셋
	 * @return java.io.InputStream
	 */
	public static InputStream openInputStream(final Reader reader, String charset)
	{
		InputStream inputStream = null;
		
		if(reader != null)
		{
			char[] charBuffer = new char[8 * 1024];
		    StringBuilder builder = new StringBuilder();
		    int numCharsRead = -1;
		    
		    try
		    {
			    while ((numCharsRead = reader.read(charBuffer, 0, charBuffer.length)) != -1) 
			    {
			        builder.append(charBuffer, 0, numCharsRead);
			    }
			    
			    if(!StringUtil.isEmpty(charset))
			    {	
			    	inputStream = new ByteArrayInputStream(builder.toString().getBytes(charset));
			    }
			    else
			    {
			    	inputStream = new ByteArrayInputStream(builder.toString().getBytes());
			    }
		    }
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
		}
		
		return inputStream;
	}
	
	/**
	 *
	 * <pre>
	 * 메소드명    : touch
	 * 설명        : 파일및 디렉토리 마지막 변경 시간정보 변경
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일객체
	 * @return boolean
	 */
	public static boolean touch(final File srcFile)
	{
		if(srcFile == null)
		{
			return false;
		}

		return touch(srcFile, System.currentTimeMillis());
	}

	/**
	 *
	 * <pre>
	 * 메소드명    : touch
	 * 설명        : 파일및 디렉토리 마지막 변경 시간정보 변경
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param srcFile 파일객체
	 * @param timestamp 시작정보
	 * @return boolean
	 */
	public static boolean touch(final File srcFile, final long timestamp)
	{
		if(srcFile == null)
		{
			return false;
		}

		try
		{
			if(!srcFile.exists())
			{
				final OutputStream out = openOutputStream(srcFile);

				close(out);
			}

			//final boolean success = srcFile.setLastModified(System.currentTimeMillis());
			return srcFile.setLastModified(timestamp);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * <pre>
	 * 메소드명   : readString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 얻는다.
	 * </pre>
	 * @param path 파일경로
	 * @return String
	 */
	public static String readString(final String path)
	{
		return readString(path, Charset.defaultCharset().name());
	}

	/**
	 * <pre>
	 * 메소드명   : readString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 얻는다.
	 * </pre>
	 * @param path 파일경로
	 * @param charset 캐릭터셋
	 * @return String
	 */
	public static String readString(final String path, final String charset)
	{
		if(path == null)
		{
			return null;
		}

		if(charset == null)
		{
			return null;
		}

		return readString(new File(path), charset);
	}

	/**
	 * <pre>
	 * 메소드명   : readString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 얻는다.
	 * </pre>
	 * @param file 파일
	 * @return String
	 */
	public static String readString(final File file)
	{
		return readString(file, Charset.defaultCharset().name());
	}

	/**
	 * <pre>
	 * 메소드명   : readString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 얻는다.
	 * </pre>
	 * @param file 파일
	 * @param charset 캐릭터셋
	 * @return String
	 */
	public static String readString(final File file, final String charset)
	{
		if(file == null)
		{
			return null;
		}

		if(charset == null)
		{
			return null;
		}

		if(!isFile(file))
		{
			return null;
		}

		FileInputStream in = openInputStream(file);

		if(in != null)
		{
			String result = readString(in, charset);

			close(in);

			return result;
		}
		else
		{
			return null;
		}
	}

	/**
	 * <pre>
	 * 메소드명   : readString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 얻는다.
	 * </pre>
	 * @param in InputStream
	 * @return String
	 */
	public static String readString(final InputStream in)
	{
		return readString(in, Charset.defaultCharset().name());
	}

	/**
	 * <pre>
	 * 메소드명   : readString
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 문자열을 얻는다.
	 * </pre>
	 * @param in InputStream
	 * @param charset 캐릭터셋
	 * @return String
	 */
	public static String readString(final InputStream in, final String charset)
	{
		if(in == null)
		{
			return null;
		}

		if(charset == null)
		{
			return null;
		}

		StringBuilder out = new StringBuilder();
		Reader reader = null;
		try
		{
			reader = new InputStreamReader(in, charset);
			char[] buffer = new char[in.available()];
			int bytesRead = -1;
			while((bytesRead = reader.read(buffer, 0, buffer.length)) != -1)
			{
				out.append(buffer, 0, bytesRead);
			}
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		finally
		{
			close(reader);
		}

		return out.toString();
	}

	/**
	 * <pre>
	 * 메소드명   : readByteArray
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일의 byte[]을 얻는다.
	 * </pre>
	 * @param path 파일경로
	 * @return byte[]
	 */
	public static byte[] readByteArray(final String path)
	{
		if(path == null || path.length() <= 0)
		{
			return null;
		}

		return readByteArray(new File(path));
	}

	/**
	 * <pre>
	 * 메소드명   : readByteArray
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일의 byte[]을 얻는다.
	 * </pre>
	 * @param file 파일객체
	 * @return byte[]
	 */
	public static byte[] readByteArray(final File file)
	{
		byte[] result = null;

		if(file == null)
		{
			return result;
		}

		if(!file.isFile())
		{
			return result;
		}


		FileInputStream in = openInputStream(file);

		if(in != null)
		{
			result = readByteArray(in);

			close(in);
		}

		return result;
	}

	/**
	 * <pre>
	 * 메소드명   : readByteArray
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : InputStream byte[]을 얻는다.
	 * </pre>
	 * @param inputStream InputStream
	 * @return byte[]
	 */
	public static byte[] readByteArray(InputStream inputStream)
	{
		byte[] result = null;

		if(inputStream != null)
		{
			ByteArrayOutputStream baos = null;

			try
			{
				baos = new ByteArrayOutputStream();
				byte[] data = new byte[inputStream.available()];
				
				int read = 0;

				while((read = inputStream.read(data, 0, data.length)) != -1)
				{
					baos.write(data, 0, read);
				}

				result = baos.toByteArray();
			}
			catch(IOException e)
			{
				e.printStackTrace();
			}
			finally
			{
				close(baos, inputStream);
			}
		}

		return result;
	}
	
	/**
	 * <pre>
	 * 메소드명   : byteToDisplay
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 바이트정보 변환 표시
	 * </pre>
	 * @param size 크기
	 * @return String
	 */
	public static String byteToDisplay(int size)
	{
		return byteToDisplay((double)size);
	}
	
	/**
	 * <pre>
	 * 메소드명   : byteToDisplay
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 바이트정보 변환 표시
	 * </pre>
	 * @param size 크기
	 * @return String
	 */
	public static String byteToDisplay(long size)
	{
		return byteToDisplay((double)size);
	}
	
	/**
	 * <pre>
	 * 메소드명   : getFilSizeUnit
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일 크기의 단위를 얻는다.
	 * </pre>
	 * @param size 파일크기
	 * @return FileSizeUnit
	 */
	public static FileSizeUnit getFilSizeUnit(int size)
	{
		return getFilSizeUnit((double)size);
	}
	
	/**
	 * <pre>
	 * 메소드명   : getFilSizeUnit
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일 크기의 단위를 얻는다.
	 * </pre>
	 * @param size 파일크기
	 * @return FileSizeUnit
	 */
	public static FileSizeUnit getFilSizeUnit(long size)
	{
		return getFilSizeUnit((double)size);
	}
	
	/**
	 * <pre>
	 * 메소드명   : getFilSizeUnit
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일 크기의 단위를 얻는다.
	 * </pre>
	 * @param size 파일크기
	 * @return FileSizeUnit
	 */
	public static FileSizeUnit getFilSizeUnit(double size)
	{
		if(size <= 0)
		{
			return FileSizeUnit.BB;
		}
		else
		{
			if(size < KILOBYTES)
			{
				return FileSizeUnit.BB;
			}
			else if(size >= KILOBYTES && size < MEGABYTES)
			{
				return FileSizeUnit.KB;
			}
			else if(size >= MEGABYTES && size < GIGABYTES)
			{
				return FileSizeUnit.MB;
			}
			else if(size >= GIGABYTES && size < TERABYTES)
			{
				return FileSizeUnit.GB;
			}
			else if(size >= TERABYTES && size < PETABYTES)
			{
				return FileSizeUnit.TB;
			}
			else if(size >= PETABYTES && size < EXABYTES)
			{
				return FileSizeUnit.PB;
			}
			else
			{
				return FileSizeUnit.EB;
			}
		}
	}

	/**
	 * <pre>
	 * 메소드명   : byteToDisplay
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 바이트정보 변환 표시
	 * </pre>
	 * @param size 크기
	 * @return String
	 */
	public static String byteToDisplay(double size)
	{
		return byteToDisplay(size, "#,###.##");
	}
	
	/**
	 * <pre>
	 * 메소드명   : byteToDisplay
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 바이트정보 변환 표시
	 * </pre>
	 * @param size    크기
	 * @param pattern 패턴
	 * @return String
	 */
	public static String byteToDisplay(double size, String pattern)
	{
		DecimalFormat df = null;
		
		if(pattern == null)
		{
			df = new DecimalFormat("#,###.##");
		}
		else
		{
			df = new DecimalFormat(pattern);
		}

		if(size <= 0)
		{
			return "0";
		}
		else
		{
			if(size < KILOBYTES)
			{
				return df.format(size);
			}
			else if(size >= KILOBYTES && size < MEGABYTES)
			{
				return df.format(size / KILOBYTES);
			}
			else if(size >= MEGABYTES && size < GIGABYTES)
			{
				return df.format(size / MEGABYTES);
			}
			else if(size >= GIGABYTES && size < TERABYTES)
			{
				return df.format(size / GIGABYTES);
			}
			else if(size >= TERABYTES && size < PETABYTES)
			{
				return df.format(size / TERABYTES);
			}
			else if(size >= PETABYTES && size < EXABYTES)
			{
				return df.format(size / PETABYTES);
			}
			else
			{
				return df.format(size / EXABYTES);
			}
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : getFileExtension
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일 확장자
	 * </pre>
	 * @param path 경로또는 파일명
	 * @return String
	 */
	public static String getFileExtension(final String path)
	{
		if(path != null && path.length() > 0)
		{
			if(path.lastIndexOf(".") != -1)
			{
				return path.toLowerCase().substring(path.lastIndexOf( "." ) + 1, path.length());
			}
		}

		return "";
	}

	/**
	 * <pre>
	 * 메소드명   : getFileExtension
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : 파일 확장자
	 * </pre>
	 * @param src 파일객체
	 * @return String
	 */
	public static String getFileExtension(final File src)
	{
		if(src == null)
		{
			return "";
		}

		String fileName = src.getName();
		if(fileName != null && fileName.length() > 0)
		{
			if(fileName.lastIndexOf(".") != -1)
			{
				return fileName.toLowerCase().substring(fileName.lastIndexOf( "." ) + 1, fileName.length());
			}
		}

		return "";
	}

	/**
	 * <pre>
	 * 메소드명    : close
	 * 설명        : 자원 해제
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param closeables java.io.Closeable
	 */
	public static void close(final Closeable... closeables)
	{
		if(closeables != null)
		{
			for (final Closeable closeable : closeables)
			{
				close(closeable);
			}
		}
	}

	/**
	 * <pre>
	 * 메소드명    : close
	 * 설명        : 자원 해제
	 * 작성일      : 2020. 12. 29.
	 * 작성자      : daekk
	 *</pre>
	 * @param closeable java.io.Closeable
	 */
	public static void close(final Closeable closeable)
	{
		try
		{
			if (closeable != null)
			{
				closeable.close();
			}
		}
		catch (final IOException e)
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : uniqueFileName
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : Unique 파일명을 얻는다.
	 * </pre>
	 * @return String
	 */
	public static String uniqueFileName()
	{
		return uniqueFileName(null);
	}
	
	/**
	 * <pre>
	 * 메소드명   : uniqueFileName
	 * 작성일     : 2020. 12. 29.
	 * 작성자     : daekk
	 * 설명       : Unique 파일명을 얻는다.
	 * </pre>
	 * @param fileExt 확장자
	 * @return String
	 */
	public static String uniqueFileName(String fileExt)
	{
		String fileName = StringUtil.replace(UUID.randomUUID().toString(), "-", "") + (StringUtil.isEmpty(fileExt) == true ? "" : "." + fileExt);
		
		return fileName;
	}
	
	// 파일 사이즈 단위 열거형
	public enum FileSizeUnit
	{
		BB("BB"), // 바이트
		KB("KB"), // 킬로바이트
		MB("MB"), // 메가바이트 
		GB("GB"), // 기가바이트
		TB("TB"), // 테라바이트
		PB("PB"), // 페타바이트
		EB("EB"); // 엑사바이트
		
		public final String value;
		
		private FileSizeUnit(String value) 
		{
			this.value = value;
		}
		
		/**
		 * <pre>
		 * 메소드명   : equals
		 * 작성일     : 2020. 12. 29.
		 * 작성자     : daekk
		 * 설명       : 같은지 비교한다.
		 * </pre>
		 * @param fileSizeUnit FileSizeUnit
		 * @return boolean
		 */
		public boolean equals(FileSizeUnit fileSizeUnit)
		{
			if(fileSizeUnit != null)
			{
				return (this == fileSizeUnit);
			}
			
			return false;
		}
		
		/**
		 * <pre>
		 * 메소드명   : equals
		 * 작성일     : 2020. 12. 29.
		 * 작성자     : daekk
		 * 설명       : 같은지 비교한다.
		 * </pre>
		 * @param value 값
		 * @return boolean
		 */
		public boolean equals(String value)
		{
			return StringUtil.equals(this.value, value);
		}
		
		/**
		 * <pre>
		 * 메소드명   : value
		 * 작성일     : 2020. 12. 29.
		 * 작성자     : daekk
		 * 설명       : 값을 얻는다.
		 * </pre>
		 * @return String
		 */
		public String value()
		{
			return value;
		}
		
		/**
		 * <pre>
		 * 메소드명   : getFileSizeUnit
		 * 작성일     : 2020. 12. 29.
		 * 작성자     : daekk
		 * 설명       : 값으로 FileSizeUnit을 얻는다.
		 * </pre>
		 * @param value 값
		 * @return
		 */
		public static FileSizeUnit getFileSizeUnit(String value)
		{
			for(FileSizeUnit fileSizeUnit : FileSizeUnit.values())
			{
				if(fileSizeUnit.equals(value))
				{
					return fileSizeUnit;
				}
			}
			
			return null;
		}
		
		@Override
		public String toString()
		{
			return value;
		}
	}
}
