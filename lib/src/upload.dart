part of flutter_uploader;

/// Abstract data structure for storing uploads.
abstract class Upload {
  /// Default constructor which specicies a [url] and [method].
  /// Sub classes may override the method for developer convenience.
  const Upload({
    required this.url,
    required this.method,
    this.headers = const <String, String>{},
    this.tag,
    this.allowCellular = true,
    required this.apiUrl,
    required this.assignmentId,
    required this.backBlazeUrl,
    required this.creatorId,
    required this.uuid,
  });

  /// Upload link
  final String url;

  /// HTTP method to use for upload (POST,PUT,PATCH)
  final UploadMethod method;

  /// HTTP headers.
  final Map<String, String>? headers;

  /// Name of the upload request (only used on Android)
  final String? tag;

  /// If uploads are allowed to use cellular connections
  /// Defaults to true. If false, uploads will only use wifi connections
  final bool allowCellular;

  final String creatorId;
  final String backBlazeUrl;
  final String uuid;
  final String apiUrl;
  final String? assignmentId;
}

/// Standard RFC 2388 multipart/form-data upload.
///
/// The platform will generate the boundaries and accompanying information.
class MultipartFormDataUpload extends Upload {
  /// Default constructor which requires either files or data to be set.
  MultipartFormDataUpload({
    required String url,
    UploadMethod method = UploadMethod.POST,
    Map<String, String>? headers,
    String? tag,
    this.files,
    this.data,
    bool allowCellular = true,
    required String creatorId,
    required String assignmentId,
    required String backBlazeUrl,
    required String apiUrl,
    required String uuid
  })  : assert(files != null || data != null),
        super(
          url: url,
          method: method,
          headers: headers,
          tag: tag,
          allowCellular: allowCellular,
        apiUrl: apiUrl,
        assignmentId: assignmentId,
        backBlazeUrl: backBlazeUrl,
        creatorId: creatorId,
        uuid: uuid
        ) {
    // Need to specify either files or data.
    assert(files!.isNotEmpty || data!.isNotEmpty);
  }

  /// files to be uploaded
  final List<FileItem>? files;

  /// additional data. Each entry will be sent as a form field.
  final Map<String, String>? data;
}

/// Also called a binary upload, this represents a upload without any form-encoding applies.
class RawUpload extends Upload {
  /// Default constructor.
  const RawUpload({
    required String url,
    UploadMethod method = UploadMethod.POST,
    Map<String, String>? headers,
    String? tag,
    this.path,
    bool allowCellular = true,
    required String creatorId,
    required String assignmentId,
    required String backBlazeUrl,
    required String apiUrl,
    required String uuid
  }) : super(
          url: url,
          method: method,
          headers: headers,
          tag: tag,
          allowCellular: allowCellular,
      apiUrl: apiUrl,
      assignmentId: assignmentId,
      backBlazeUrl: backBlazeUrl,
      creatorId: creatorId,
      uuid: uuid
        );

  /// single file to upload
  final String? path;
}
