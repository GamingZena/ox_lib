/**
 * Simple wrapper around fetch API tailored for CEF/NUI use. This abstraction
 * can be extended to include AbortController if needed or if the response isn't
 * JSON. Tailor it to your needs.
 *
 * @param eventName - The endpoint eventname to target
 * @param data - Data you wish to send in the NUI Callback
 *
 * @return returnData - A promise for the data sent back by the NuiCallbacks CB argument
 */

<<<<<<< HEAD
=======
const fetch = window.fetch;
// @ts-expect-error
window.fetch = () => {};
// @ts-expect-error
window.XMLHttpRequest = window.fetch;

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
export async function fetchNui<T = any>(eventName: string, data?: any): Promise<T> {
  const options = {
    method: 'post',
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify(data),
  };

  const resourceName = (window as any).GetParentResourceName
    ? (window as any).GetParentResourceName()
    : 'nui-frame-app';

  const resp = await fetch(`https://${resourceName}/${eventName}`, options);
<<<<<<< HEAD

=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
  const respFormatted = await resp.json();

  return respFormatted;
}
