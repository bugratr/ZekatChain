$(document).ready(function() {
    fetchApplicants();
});

function fetchApplicants() {
    $.get('getApplicants.php', function(data) {
        let applicants = JSON.parse(data);
        let output = '';
        applicants.forEach(applicant => {
            output += `
            <tr>
                <td>${applicant.id}</td>
                <td>${applicant.name}</td>
                <td>${applicant.tc_kimlik}</td>
                <td>${applicant.email}</td>
                <td>${applicant.phone}</td>
                <td><a href="${applicant.document_path}" target="_blank">Belge Görüntüle</a></td>
            </tr>`;
        });
        $('#applicantsList').html(output);
    });
}
