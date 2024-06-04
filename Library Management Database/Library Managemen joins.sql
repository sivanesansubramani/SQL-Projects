	use db_LibraryManagement;
	
	SELECT * FROM tbl_library_branch;
	SELECT * FROM tbl_borrower;
	SELECT * FROM tbl_book_loans;
	SELECT * FROM tbl_book_copies;
	SELECT * FROM tbl_book_authors;
	SELECT * FROM tbl_publisher;
	SELECT * FROM tbl_book;



	-- select seperate count of each book in each branch
	SELECT tlbb.library_branch_BranchName as 'Branch Location',bb1.book_Title as 'Book Name',
	bb1.book_PublisherName as 'Book Name',tbb1.book_copies_No_Of_Copies as 'Copies in Branch' FROM tbl_book_copies as tbb1 
	inner join tbl_library_branch as tlbb 
	on tbb1.book_copies_BranchID = tlbb.library_branch_BranchID inner join tbl_book as bb1 on tbb1.book_copies_BookID = bb1.book_BookID;

	-- total number of books in each branch
	SELECT t2.library_branch_BranchName,sum(t1.book_copies_No_Of_Copies) FROM tbl_book_copies as t1 inner join 
	tbl_library_branch as t2 on t1.book_copies_BookID = t2.library_branch_BranchID
	group by t2.library_branch_BranchName;

	-- select how many books written by each author
	SELECT book_authors_AuthorName ,count(book_authors_AuthorID) FROM tbl_book_authors group by book_authors_AuthorName
	order by count(book_authors_AuthorID) desc;

	-- total no of books borrowed by each browers
	SELECT tb2.borrower_BorrowerName as 'Name',tb1.book_loans_CardNo,count(tb1.book_loans_CardNo) as 'No of books'
	FROM tbl_book_loans as tb1
	inner join tbl_borrower as tb2 on tb1.book_loans_CardNo = tb2.borrower_CardNo
	group by tb1.book_loans_CardNo, tb2.borrower_BorrowerName;



